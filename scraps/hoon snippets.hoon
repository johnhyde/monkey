-test %%%/monkey/=/tests/lib/monkey ~

=re -build-file %%%/monkey/=/lib/re/hoon
=mke -build-file %%%/monkey/=/lib/monkey/hoon

.^((list [=binding:eyre =duct =action:eyre]) %e /(scot %p our)/bindings/(scot %da now))
.^((list [=binding:eyre =duct =action:eyre]) %e /=/bindings/=)
.^(noun %gx /=/monkey/=/patches/noun)

:monkey &patch [/astrolabe/test /apps/astrolabe [%path [%before "<script"] '<script>alert("you\'ve been hacked")</script>']]

:monkey &patch [/groups/astrolabe/link /apps/groups [[%cord '/apps/groups/desk.js'] [%before "."] t]]
