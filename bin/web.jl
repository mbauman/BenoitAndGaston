using BenoitAndGaston: descend, julia

using Dash
using PNGFiles: save
using Base64: base64encode

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
    save(buf, img)
    seekstart(buf)
    return (string(c),
            "data:image/png;base64," * base64encode(buf))
end

run_server(app)