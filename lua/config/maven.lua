local M = {}

local uv = vim.uv or vim.loop

local function notify(message, level)
  vim.schedule(function() vim.notify(message, level or vim.log.levels.INFO, { title = "Java" }) end)
end

local function project_root(bufnr)
  local root = vim.fs.root(bufnr or 0, {
    "pom.xml",
    "build.gradle",
    "build.gradle.kts",
    "gradlew",
    "mvnw",
    ".git",
  })
  if root and root ~= "" then return root end
  return uv.cwd() or vim.fn.getcwd()
end

local function maven_executable(root)
  local wrapper = vim.fs.joinpath(root, "mvnw")
  if uv.fs_stat(wrapper) then return wrapper end
  return "mvn"
end

local function open_terminal(title, cwd, argv)
  vim.cmd "botright 16split"
  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].buflisted = false
  vim.api.nvim_buf_set_name(buf, title)
  vim.fn.jobstart(argv, {
    term = true,
    cwd = cwd,
    on_exit = function(_, code)
      notify(
        ("%s finished with exit code %d"):format(title, code),
        code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
      )
    end,
  })
  vim.cmd "startinsert"
end

local function run_maven(args, opts)
  local root = (opts and opts.cwd) or project_root(0)
  local exe = maven_executable(root)
  local argv = type(args) == "string" and vim.split(args, "%s+", { trimempty = true }) or args
  local title = (opts and opts.title) or ("Maven: " .. table.concat(argv, " "))
  argv = vim.list_extend({ exe }, argv)
  open_terminal(title, root, argv)
end

function M.setup()
  vim.api.nvim_create_user_command(
    "Mvn",
    function(opts) run_maven(opts.fargs, { title = "Maven: " .. opts.args }) end,
    { nargs = "+", desc = "Run Maven goals" }
  )

  local commands = {
    MvnClean = { "clean" },
    MvnCompile = { "compile" },
    MvnTest = { "test" },
    MvnPackage = { "package" },
    MvnInstall = { "install" },
    MvnVerify = { "verify" },
    MvnDependencyTree = { "dependency:tree" },
  }

  for name, args in pairs(commands) do
    vim.api.nvim_create_user_command(
      name,
      function() run_maven(args, { title = "Maven: " .. table.concat(args, " ") }) end,
      { desc = "Run " .. table.concat(args, " ") }
    )
  end
end

return M
