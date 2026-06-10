function E = KazaETuned(s, r, N);

E = [exp(2*pi*1i*s*r/N), 0; 0, exp(2*pi*1i*s*r/N)];

end
