local present, webdevicons = pcall(require, "nvim-web-devicons")
if not present then
  return
end

webdevicons.set_icon {
  astro = {
    --  󱓟 
    icon = "󱓞",
    color = "#FF7E33",
    name = "astro",
  },
}
