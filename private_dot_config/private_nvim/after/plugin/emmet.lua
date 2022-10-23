local present, emmet = pcall(require, "emmet")

if not present then
  return
end

g.user_emmet_install_global = 0
g.user_emmet_mode = "a" -- enable all function in all mode.
