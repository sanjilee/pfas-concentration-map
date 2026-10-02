import { test } from "node:test";
import assert from "node:assert/strict";
import { calculateOverview, compoundResult, statistics, formatDate, getSeries, formatValue } from "../lib/pfas/calculations";
import type { Sample, Measurement } from "../lib/pfas/types";
const m = (code: string, value: number | null, detected = value !== null): Measurement => ({ id: code, value, detected, unit: "ng/L", analytes: {id:code,code,full_name:code,display_order:1} });
const sample = (measurements: Measurement[]): Sample => ({id:"s1",sample_code:"test",collected_on:"2026-04-10",measurements});
test("overview sums selected detections without substituting ND",()=>{
  const s=sample([m("PFBA",2),m("PFOA",4),m("PFOS",null)]);
  assert.equal(calculateOverview(s,["PFBA","PFOA","PFOS"]).value,6);
  assert.equal(calculateOverview(s,["PFBA","PFOS"]).value,2);
});
test("an incomplete overview never masquerades as a complete sum",()=>{
  const r=calculateOverview(sample([m("PFBA",1.3),m("PFHxA",null)]),["PFBA","PFHxA","PFOS"]);
  assert.equal(r.status,"incomplete");assert.equal(r.available,2);assert.equal(r.value,null);
});
test("all ND, no results, and no selection remain distinct",()=>{
  const s=sample([m("PFBA",null)]);
  assert.equal(calculateOverview(s,["PFBA"]).status,"nd");
  assert.equal(calculateOverview(s,["PFOS"]).status,"missing");
  assert.equal(calculateOverview(s,[]).status,"unselected");
});
test("individual missing and ND results remain distinct",()=>{
  const s=sample([m("PFBA",null)]);
  assert.equal(compoundResult(s,"PFBA").status,"nd");
  assert.equal(compoundResult(s,"PFOS").status,"missing");
});
test("detected-only statistics exclude ND and missing",()=>{
  const results=[2,4,null].map(v=>compoundResult(sample([m("PFBA",v)]),"PFBA"));
  assert.deepEqual(statistics(results),{count:2,min:2,average:3,max:4});
});
test("a detected zero is retained",()=>{
  assert.equal(calculateOverview(sample([m("PFBA",0)]),["PFBA"]).status,"detected");
  assert.equal(statistics([compoundResult(sample([m("PFBA",0)]),"PFBA")]).min,0);
});
test("invalid numeric values never reach calculations",()=>{
  for(const value of [Infinity,NaN,-1]) assert.equal(compoundResult(sample([m("PFBA",value)]),"PFBA").status,"missing");
});
test("date-only labels do not shift in America/Chicago",()=>{
  process.env.TZ="America/Chicago";assert.equal(formatDate("2026-04-10"),"Apr 10, 2026");
});
test("latest sample stays latest even when its compound result is missing",()=>{
  const a=sample([m("PFBA",2)]),b={...sample([]),id:"s2",collected_on:"2026-05-10"};
  const rows=getSeries([b,a],"PFBA",[]);assert.equal(rows.at(-1)?.status,"missing");
});
test("tiny detected values are not displayed as zero",()=>assert.notEqual(formatValue(0.00000003),"0"));
