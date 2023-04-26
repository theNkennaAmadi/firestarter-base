uniform float uTime;
uniform vec2 uResolution;
uniform sampler2D uTexture;

varying vec2 vUv;

float wave(int i, vec2 p, float offset, float t) {
    // Get some pseudo random values for the wave.
    vec4 r = texture2D(uTexture, vec2(float(i)/256.0,0.0)) * vec4(1.0, 5.0, 7.0, 11.0);

    // Get the y-distance from p.y to the wave.
    float y = abs(
        offset + 0.5 * (
        sin(r.x*t + r.y*p.x) *
        sin(r.z*t + r.w*p.x)) -
        p.y);

    // Modify the distance value to get something visually pleasing.
    return asin(clamp(1.0 - y*30.0, 0.0, 1.0));
}

void main()
{
    // Normalize the x-position, and scale y accordingly.
     vec2 p = (gl_FragCoord.xy - 0.5*uResolution.xy)/uResolution.y;

    // Add the waves.
    float t = 20.0 + 0.5 * uTime;
    float v =
    wave(0, p,    0.2, t) +
    wave(1, p,    0.4, t) +
    wave(3, p,    0.6, t) +
    wave(4, p,    0.8, t) +
    wave(4, p.yx, 0.2, t) +
    wave(5, p.yx, 0.4, t) +
    wave(6, p.yx, 0.6, t) +
    wave(7, p.yx, 0.8, t);

    //vec4 textureColor = texture2D(uTexture, vUv);
    //vec2 st = gl_FragCoord.xy/uResolution;
    gl_FragColor = vec4(v, v, v, 1.0) - vec4(2.0, 2.5, 21.0, 0.0);
}
