function Gs = KazaGTuned(s, mu_s, r_a_s, omega_a_s, omega_h_s, zeta_a_s, zeta_h_s, omega_0);


  gamma_h_s = omega_h_s/omega_0;
  gamma_a_s = omega_a_s/omega_0;

  G_Kh_s = mu_s*(gamma_h_s^2)*(1+2i*zeta_h_s);
  G_Ka_s = mu_s*(r_a_s^2)*(gamma_a_s^2)*(1+2i*zeta_a_s);

  G11 = 1/G_Kh_s;
  G12 = 0;
  G21 = 0;
  G22 = 1/G_Ka_s;

  Gs= [G11, G12; G21, G22];

 end
