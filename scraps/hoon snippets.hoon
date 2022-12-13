-test %%%/monkey/=/tests/lib/monkey ~

=re -build-file %%%/monkey/=/lib/re/hoon
=mke -build-file %%%/monkey/=/lib/monkey/hoon

.^((list [=binding:eyre =duct =action:eyre]) %e /(scot %p our)/bindings/(scot %da now))
.^((list [=binding:eyre =duct =action:eyre]) %e /=/bindings/=)
