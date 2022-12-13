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
    %+  expect-eq
      !>  html
      !>  (thatch-hatch straw replace+"not found" html)
  ==
++  test-ruts
  ;:  weld
    %+  expect-eq
      !>  [~ ~]
    !>  (ruts ~ ~ |=([@ (unit @) (unit @) ~] [`1 ~]))
    ::
    =/  m1=(map term @t)
      %-  malt
      ^-  (list [term @t])
      :~  i1+'longer'
          i2+'longer'
          i4+'longer'
          i6+'longer'
      ==
    =/  m2=(map term @t)
      %-  malt
      ^-  (list [term @t])
      :~  i2+'short'
          i3+'short'
          i5+'short'
          i6+'short'
      ==
    =/  m3=(map term @t)
      %-  malt
      ^-  (list [term @t])
      :~  i1+'longer'
          i2+'longer'
          i3+'short'
          i4+'longer'
          i5+'short'
      ==
    ::
    %+  expect-eq
      !>  [m3 /a/a/a/a/a/a]
    !>  %^  ruts  m1  m2
    |=  [k=term v1=(unit @t) v2=(unit @t) a=path]
    ^-  [(unit cord) path]
    :_  `(list @t)`['a' a]
    ^-  (unit cord)
    ?:  =(k %i6)  ~
    ?~  v1  v2
    ?~  v2  v1
    ?:  (gth (met 3 u.v1) (met 3 u.v2))
      v1
    v2
  ==
++  test-merge-shirts
  =/  e-shirts=shirts
    %-  malt
    ^-  (list [watch shirt])
    :~
        [/e-only/no-app [%.n ~]]
        [/e-only/app [%.n `%app]]
        [/e-only/ours [%.y ~]]
        ::
        [/both/ours-same/no-app/a [%.n ~]]
        [/both/ours-same/no-app/b [%.n ~]]
        [/both/ours-same/app/a [%.n `%app]]
        [/both/ours-same/app/b [%.n `%app]]
        [/both/ours-same/app/c [%.n `%app]]
        [/both/ours-same/ours/a [%.y ~]]
        [/both/ours-same/ours/b [%.y ~]]
        ::
        [/both/ours-diff/no-app/a [%.n ~]]
        [/both/ours-diff/no-app/b [%.n ~]]
        [/both/ours-diff/app/a [%.n `%app]]
        [/both/ours-diff/app/b [%.n `%app]]
        [/both/ours-diff/app/c [%.n `%app]]
        [/both/ours-diff/ours/a [%.y ~]]
        [/both/ours-diff/ours/b [%.y ~]]
    ==
  =/  s-shirts=shirts
    %-  malt
    ^-  (list [watch shirt])
    :~
        [/s-only/no-app [%.n ~]]
        [/s-only/app [%.n `%app]]
        [/s-only/our-sub [%.y ~]]
        [/s-only/our-rep [%.y `%app]]
        ::
        [/both/ours-same/no-app/a [%.n ~]]
        [/both/ours-same/no-app/b [%.n `%app]]
        [/both/ours-same/app/a [%.n ~]]
        [/both/ours-same/app/b [%.n `%app]]
        [/both/ours-same/app/c [%.n `%diff]]
        [/both/ours-same/ours/a [%.y ~]]
        [/both/ours-same/ours/b [%.y `%app]]
        ::
        [/both/ours-diff/no-app/a [%.y ~]]
        [/both/ours-diff/no-app/b [%.y `%app]]
        [/both/ours-diff/app/a [%.y ~]]
        [/both/ours-diff/app/b [%.y `%app]]
        [/both/ours-diff/app/c [%.y `%diff]]
        [/both/ours-diff/ours/a [%.n ~]]
        [/both/ours-diff/ours/b [%.n `%app]]
    ==
  =/  m-shirts=shirts
    %-  malt
    ^-  (list [watch shirt])
    :~  
        [/e-only/no-app [%.n ~]]
        [/e-only/app [%.n `%app]]
        :: eyre-only !ours: keep
        :: [/e-only/ours [%.y ~]]
        :: eyre-only ours: disconn+remove
        :: we can't handle those reqs
        ::
        :: [/s-only/no-app [%.n ~]]
        :: [/s-only/app [%.n `%app]]
        :: out of date: remove
        [/s-only/our-sub [%.y ~]]
        :: our sub was removed: conn+keep
        [/s-only/our-rep [%.y ~]]
        :: our replacer was removed: conn+make-sub
        ::
        [/both/ours-same/no-app/a [%.n ~]]
        :: same: keep
        [/both/ours-same/no-app/b [%.n ~]]
        :: new info: update
        [/both/ours-same/app/a [%.n `%app]]
        :: new info: update
        [/both/ours-same/app/b [%.n `%app]]
        :: same: keep
        [/both/ours-same/app/c [%.n `%app]]
        :: new info: update
        [/both/ours-same/ours/a [%.y ~]]
        :: same: keep
        [/both/ours-same/ours/b [%.y `%app]]
        :: state is richer: keep
        ::
        [/both/ours-diff/no-app/a [%.n ~]]
        :: off limits: update+remove-refs
        [/both/ours-diff/no-app/b [%.n ~]]
        :: off limits: update+remove-refs
        [/both/ours-diff/app/a [%.y `%app]]
        :: sub was overwritten: reconn+make-replacer
        [/both/ours-diff/app/b [%.y `%app]]
        :: replacer was overwritten: reconn+keep-app
        [/both/ours-diff/app/c [%.y `%app]]
        :: replacer was overwritten: reconn+update-app
        :: [/both/ours-diff/ours/a [%.y ~]]
        :: [/both/ours-diff/ours/b [%.y ~]]
        :: eyre-only ours: disconn+remove
        :: we can't handle those reqs
    ==
  %+  expect-eq
    !>
    :-
      %-  silt  ^-  (list card:agent:gall)
      %-  limo
      :~
        (disconnect-card /e-only/ours)
        (disconnect-card /both/ours-diff/ours/a)
        (disconnect-card /both/ours-diff/ours/b)
        (connect-card /s-only/our-sub)
        (connect-card /s-only/our-rep)
        (connect-card /both/ours-diff/app/a)
        (connect-card /both/ours-diff/app/b)
        (connect-card /both/ours-diff/app/c)
      ==
    m-shirts
  !>
  =-  [(silt -<) ->]
  (merge-shirts e-shirts s-shirts)
--
