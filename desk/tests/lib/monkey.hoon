::  tests for number-to-words
::
/-  *monkey
/+  *monkey, *test
::
=/  straw=thatch
'''
<script>alert("you've been hacked")</script>
'''
=/  html
'''
<html>
  <script src="/main.js"></script>
</html>
'''
|%
++  test-thatch-hatch
  ;:  weld
    %-  expect-eq
      :_  !>  (thatch-hatch straw before+"<script" html)
      !>
'''
<html>
  <script>alert("you've been hacked")</script><script src="/main.js"></script>
</html>
'''
    %-  expect-eq
      :_  !>  (thatch-hatch straw after+"/script>" html)
      !>
'''
<html>
  <script src="/main.js"></script><script>alert("you've been hacked")</script>
</html>
'''
    %-  expect-eq
      :_  !>  (thatch-hatch straw replace+"ml>.+</ht" html)
      !>
'''
<ht<script>alert("you've been hacked")</script>ml>
'''
  ==
--
