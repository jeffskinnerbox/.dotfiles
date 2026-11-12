-- render-markdown hides code-block fence lines ("hide"), and snacks anchors the mermaid/math image
-- on the closing fence, so the image only showed while the cursor was on that line.
-- keep the fences visible so the image stays anchored.
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    opts = {
      code = { border = "none" },
    },
  },
}
