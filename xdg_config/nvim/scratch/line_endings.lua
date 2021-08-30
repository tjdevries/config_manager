local test = "hello\nworld\nthis\r\nis\ntrue"

P(vim.split(test, "\r?\n"))
