defmodule UsOfBb.Animate do
  @moduledoc """
  Show the adoption rate of BB across the United States using NeoPixel LEDS.
  """

  alias Nerves.Neopixel

  def state_pixel_values do
    States.display_colors(States.states)
      |> Enum.flat_map(fn(color) -> Color.values(color) end)
      |> List.foldr(<<>>, fn(a, b) -> << a, b >> end)
  end

  def lights_on(channel) do
    spawn fn () -> lights_on_forever(channel) end
  end

  def lights_on_forever(channel) do
    Neopixel.render(channel, state_pixel_values)
    :timer.sleep(100)
    lights_on_forever(channel)
  end

end
