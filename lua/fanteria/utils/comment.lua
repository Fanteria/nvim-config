local comment_ok, comment = pcall(require, "Comment")
if not comment_ok then
  print("Comment cannot be loaded.")
  return
end

comment.setup()

-- This plugin add few mappings
-- gcc to comment act line with line comment
-- gbc to comment act line with block comment
-- gc  to comment visual block with line comment
-- gb  to comment visual block with block comment
-- gcA to add line comment on the end of the line
