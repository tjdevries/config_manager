local M = {}

M._current_job_id = -1

M.set_job_id = function(job_id)
  job_id = job_id or vim.b.term_job_id

  M._current_job_id = job_id
end

M.send_to_term = function(input)
  vim.fn.chansend(M._current_job_id, { input .. "\r\n" })
end

return M
