using JuliaCon2024: descend, julia

using Dash
using Images: save
using Base64: base64encode
using FileIO: Stream, @format_str

app = dash()

app.layout = html_div([
    html_h1("hello JuliaCon!"),
    html_button("Go!", id="button"),
    html_p("", id="loc"),
    html_img(id="img")
])

callback!(app, [Output("loc", "children"), Output("img", "src")], Input("button", "n_clicks")) do click
    c = descend(randn(Complex{Float64}))
    img = julia(range(-1,1,800), range(-1,1,600), c)
    buf = IOBuffer()
    save(Stream{format"PNG"}(buf), img)
    seekstart(buf)
    return (string(c),
            "data:image/png;base64," * base64encode(buf))
end

run_server(app)