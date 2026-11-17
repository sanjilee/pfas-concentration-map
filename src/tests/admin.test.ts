import { test } from "node:test";
import assert from "node:assert/strict";
import { measurementPayload, adminError } from "../lib/pfas/admin";

test("missing, ND and detected zero have distinct persisted representations", () => {
  assert.deepEqual(measurementPayload([
    { analyte_id: "a", status: "missing", value: "" },
    { analyte_id: "b", status: "nd", value: "" },
    { analyte_id: "c", status: "detected", value: "0" },
  ]), [{ analyte_id: "b", detected: false, value: null }, { analyte_id: "c", detected: true, value: 0 }]);
});
test("blank, negative and nonfinite detections are rejected", () => {
  for (const value of ["", " ", "-1", "NaN", "Infinity", "1e999", "oops"]) {
    assert.throws(() => measurementPayload([{ analyte_id: "a", status: "detected", value }]));
  }
});
test("small detected values preserve precision", () => {
  assert.equal(measurementPayload([{ analyte_id: "a", status: "detected", value: "0.00000003" }])[0].value, 0.00000003);
});
test("duplicate analytes cannot be submitted", () => {
  assert.throws(() => measurementPayload([{ analyte_id: "a", status: "nd", value: "" }, { analyte_id: "a", status: "missing", value: "" }]));
});
test("conflicts and permission errors provide useful recovery without database internals", () => {
  assert.match(adminError({ code: "40001" }), /Another editor/);
  assert.match(adminError({ code: "42501" }), /Editor access/);
  assert.doesNotMatch(adminError({ message: "private internals" }), /private internals/);
});
