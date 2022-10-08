/-  sur=monkey
:: /+  azimuth, naive, mip
=<  [sur .]
=,  sur
|%
++  patch-response-data
  |=  [=wire data=octs patch=@t]
  ^-  octs
  =/  text  ((sand %t) q.data)
  ?~  text  data
  =/  final  (cat 3 patch u.text)
  [(met 3 final) final]
--
