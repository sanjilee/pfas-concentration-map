export type ResultInput = { analyte_id: string; status: "missing" | "nd" | "detected"; value: string };

export function measurementPayload(rows: ResultInput[]) {
  const ids = new Set<string>();
  return rows.flatMap(row => {
    if (ids.has(row.analyte_id)) throw new Error("Duplicate compound.");
    ids.add(row.analyte_id);
    if (row.status === "missing") return [];
    if (row.status === "nd") return [{ analyte_id: row.analyte_id, detected: false, value: null as number | null }];
    if (row.status !== "detected" || !row.value.trim()) throw new Error("Enter a concentration for every detected result.");
    const value = Number(row.value);
    if (!Number.isFinite(value) || value < 0) throw new Error("Concentrations must be finite, nonnegative numbers.");
    return [{ analyte_id: row.analyte_id, detected: true, value }];
  });
}

export function adminError(error: { code?: string; message?: string }) {
  if (error.code === "40001") return "Another editor changed this record. Reload the list and reopen it before trying again.";
  if (error.code === "23505") return "That code already exists. Use a unique site or sample code.";
  if (error.code === "42501") return "Editor access is required. Ask the project administrator to check your account.";
  if (error.code === "P0002") return "This record was deleted. Reload the list.";
  if (error.code === "23503") return "A referenced site or compound no longer exists. Reload the list.";
  return "Unable to complete the request. Check your connection and fields, then try again. If it persists, ask the administrator to check the database setup.";
}
