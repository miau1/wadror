json.array!(@styles) do |style|
  json.extract! style, :id, :name, :text
  json.url style_url(style, format: :json)
end
