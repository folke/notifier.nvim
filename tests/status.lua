local notifier = require 'notifier'
local status = require 'notifier.status'
require 'busted.runner' { output = 'TAP', shuffle = true }

local function get_status_lines()
  return vim.api.nvim_buf_get_lines(status.buf_nr, 0, -1, true)
end

local function assert_status(lines)
  assert.are.Same(get_status_lines(), lines)
end

notifier.setup {
  components = { "test" },
  status_width = 40
}

describe('status window', function()

  before_each(function()
    vim.o.columns = 100
    vim.o.textwidth = 40
    vim.o.lines = 100
  end)

  it('works', function()
    status.push("test", "test")
    assert_status {
      '                               test test'
    }
  end)
end)
