local hop_ok, hop = pcall(require, "hop")
if not hop_ok then
  print("Hop cannot be loaded.")
  return
end

hop.setup()
