shader_type canvas_item;


// 1) Hash: convierte una posición en un número "aleatorio" estable [0,1]
float hash(vec2 p) {
	return fract(sin(dot(p, vec2(127.1, 411.7))) * 43758.5453);
}

// 2) Ruido de valor: interpola suave entre las 4 esquinas de cada celda
float ruido(vec2 p) {
	vec2 i = floor(p);
	vec2 f = fract(p);
	float a = hash(i);
	float b = hash(i + vec2(1.0, 0.0));
	float c = hash(i + vec2(0.0, 1.0));
	float d = hash(i + vec2(1.0, 1.0));
	vec2 u = f * f * (3.0 - 2.0 * f);          // curva suave (smoothstep)
	return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

// 3) FBM: suma varias octavas de ruido, cada vez más fino y más tenue
float fbm(vec2 p) {
	float valor = 0.0;
	float amplitud = 0.5;
	for (int i = 0; i < 5; i++) {
		valor += amplitud * ruido(p);
		p *= 2.0;          // duplica la frecuencia (más detalle)
		amplitud *= 0.5;   // baja la amplitud (menos peso)
	}
	return valor;
}

void fragment() {
	vec2 uv = UV * 3.0;
	float t = TIME * 0.2;

	// 4) Domain warping: usamos ruido para DEFORMAR las coordenadas
	//    de otro ruido. Esto es lo que da el aspecto orgánico y fluido.
	vec2 q = vec2(fbm(uv + t), fbm(uv + vec2(5.2, 1.3) - t));
	float n = fbm(uv + 4.0 * q + t);

	// Rampa de color: azul oscuro → naranja → amarillo brillante
	vec3 color = mix(vec3(0.0, 0.0, 0.1), vec3(0.2, 1.0, 0.0), n);
	color = mix(color, vec3(1.0, 1.0, 0.6), pow(n, 3.0));

	COLOR = vec4(color, 1.0);
}
