shader_type canvas_item;

uniform vec2 player_pos;      // Player global_position
uniform vec2 tilemap_pos;     // TileMap global_position
uniform float radius = 16.0;  // Radius der Abdunklung
uniform float shade = 0.6;    // Abdunkelungsfaktor

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    // Pixelposition im Weltkoordinatensystem
    vec2 world_pos = tilemap_pos + FRAGCOORD.xy - SCREEN_PIXEL_SIZE.xy * vec2(0.5);

    // Abstand zum Spieler
    float dist = length(world_pos - player_pos);

    // Abdunkeln, wenn Spieler darüber
    float factor = (dist < radius) ? shade : 1.0;

    COLOR = tex * factor;
}
