/-  sur=monkey
:: /+  azimuth, naive, mip
=<  [sur .]
=,  sur
|%
++  maybe-apply-patch
  |=  [=patch data=octs]
  (patch-response-data data thatch.patch)
++  patch-response-data
  |=  [data=octs patch=@t]
  ^-  octs
  =/  text  ((sand %t) q.data)
  ?~  text  data
  =/  final  (cat 3 patch u.text)
  [(met 3 final) final]
--
