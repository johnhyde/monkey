/-  *monkey
/+  *monkey, default-agent, dbug, agentio
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
    slivs=(map path sliv)
  ==
::
+$  sliv  [cuff=(unit binding:eyre) app=term]
+$  card  card:agent:gall
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
=<
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
    hc    ~(. +> bowl)
::
++  on-init
  ^-  (quip card _this)
  :_  this
  [%pass /eyre-test %arvo %e %connect [~ /apps/astrolabe] %monkey]~
::
++  on-save  !>(state)
++  on-load
  |=  old-state=vase
  ^-  (quip card _this)
  =/  old  !<(versioned-state old-state)
  :: =/  old  *state-0
  :_  this(state old)
  ~
  :: :~
  ::   :: [%pass /eyre-test %arvo %e %connect [~ /apps/astrolabe] %monkey]
  ::   :: [%pass /eyre-test %arvo %e %connect [~ /pals] %pals]
  :: ==
++  on-poke
  :: on-poke:def
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+    mark  (on-poke:def mark vase)
      %bind
    =+  !<(=path vase)
    =/  sliv  (get-sliv-for-path-from-bindings:hc path)
    ?~  sliv  `this
    =.  slivs.state
      (~(put by slivs.state) path u.sliv)
    :_  this
    [%pass /eyre-test %arvo %e %connect [~ path] %monkey]~
      %unbind
    =+  !<(=path vase)
    =/  sliv  (~(get by slivs.state) path)
    ?~  sliv  `this
    =/  cards
      ?~  cuff.u.sliv
        [%pass /eyre-test %arvo %e %disconnect [~ path]]~
      [%pass /eyre-test %arvo %e %connect u.cuff.u.sliv app.u.sliv]~
    =.  slivs.state
      (~(del by slivs.state) path)
    [cards this]
      %unbind-app
    =+  !<(app=term vase)
    :_  this
    [%pass /eyre-test %arvo %e %disconnect [~ /apps/[app]]]~
      %handle-http-request
    =+  !<([eyre-id=@ta req=inbound-request:eyre] vase)
    ?~  &(authenticated.req secure.req)  !!
    =/  path  site:(parse-request-line url.request.req)
    ~&  url.request.req
    ~&  path
    :: =/  sliv  (~(get by slivs.state) path)
    =/  sliv  (get-sliv-for-path-from-slivs path)
    ~&  sliv
    :: =/  res  'hello, world'
    =/  paths  ~[/http-response/[eyre-id]]
    :_  this
    ?~  sliv
      ~&  "attempting to send 500"
      :~
        [%give %fact paths %http-response-header !>(`response-header:http`[500 ~])]
        [%give %fact paths %http-response-data !>(*(unit octs))]
        [%give %kick paths ~]
      ==
    :~
      [%pass /relay/[eyre-id] %agent [our.bowl app.u.sliv] %watch /http-response/[eyre-id]]
      [%pass /relay/[eyre-id] %agent [our.bowl app.u.sliv] %poke [mark vase]]
      ::  :*
      ::   %give
      ::   %fact
      ::   paths
      ::   %http-response-data
      ::   !>(`(unit octs)``[(met 3 res) res])
      :: ==
      :: [%give %kick paths ~]
    ==
  ==
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+    path
    (on-watch:def path)
  ::
      [%http-response *]
    %-  (slog leaf+"Eyre subscribed to {(spud path)}." ~)
    `this
  ==
++  on-leave
  |=  =path
  ^-  (quip card _this)
  :-  ~
  this
::
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?+    path  (on-peek:def path)
      [%x %null ~]
    ``noun+!>(~)
  ==
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+    wire  (on-agent:def wire sign)
      [%relay @ta ~]
    =/  res-paths  (res-paths:hc &2.wire)
    ?+    -.sign  (on-agent:def wire sign)
        %kick
      :_  this
      [%give %kick res-paths ~]~
        %fact
      ?+    p.cage.sign  (on-agent:def wire sign)
          %http-response-header
        ~&  "header received"
        :_  this
        [%give %fact res-paths cage.sign]~
          %http-response-data
        =/  data  !<((unit octs) q.cage.sign)
        =.  data
          ?~  data  ~
          (some (patch-response-data wire u.data example-patch))
        :_  this
        [%give %fact res-paths %http-response-data !>(data)]~
      ==
    ==
  ==
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?.  ?=([%eyre-test *] wire)
    (on-arvo:def [wire sign-arvo])
  ?>  ?=([%eyre %bound *] sign-arvo)
  ?:  accepted.sign-arvo
    %-  (slog leaf+"{<path.binding.sign-arvo>} bound successfully!" ~)
    `this
  %-  (slog leaf+"Binding {<path.binding.sign-arvo>} failed!" ~)
  `this
++  on-fail  on-fail:def
--
::
:: Helper Core
|_  =bowl:gall
++  scrio  ~(scry agentio bowl)
++  az-events-card  [%pass /azimuth-events %agent [our.bowl %azimuth] %watch /event]
++  res-paths
  |=  id=@ta
  ~[/http-response/[id]]
::
:: ++  read-doc
::   |=  =path
::   =/  doc-path=^path  :(weld /doc/usr path /udon)
::   ^-  (unit @t)
::   ?.  .^(? %cu (scrio q.byk.bowl doc-path))
::     ~
::   =/  mme=(each manx tang)  (mule |.((udon-to-docu .^(@t %cx (scrio q.byk.bowl doc-path)))))
::   ?:  ?=(%.n -.mme)
::     %-  (slog p.mme)
::     ~
::   `(crip (en-xml:html p.mme))::  +find-suffix: returns [~ /tail] if :full is (weld :prefix /tail)
++  get-sliv-for-path-from-slivs
  |=  =path
  ^-  (unit sliv)
  =/  slivs  ~(tap by slivs.state)
  |-  ^-  (unit sliv)
  ?~  slivs  ~
  =/  suffix  (find-suffix p.i.slivs path)
  ?~  suffix
    $(slivs t.slivs)
  `q.i.slivs
::
++  get-sliv-for-path-from-bindings
  |=  =path
  ^-  (unit sliv)
  =/  bindings  .^((list [=binding:eyre =duct =action:eyre]) %e (scrio %bindings ~))
  |-  ^-  (unit sliv)
  ?~  bindings  ~
  =/  suffix  (find-suffix path.binding.i.bindings path)
  ?~  suffix
    $(bindings t.bindings)
  =/  action  action.i.bindings
  ?.  ?=([%app app=term] action)
    ~
  :-  ~
  :_  +.action
  ?~  u.suffix
    (some binding.i.bindings)
  ~
::
++  find-suffix
  |=  [prefix=path full=path]
  ^-  (unit path)
  ?~  prefix
    `full
  ?~  full
    ~
  ?.  =(i.prefix i.full)
    ~
  $(prefix t.prefix, full t.full)
::
++  parse-request-line
  |=  url=@t
  ^-  [[ext=(unit @ta) site=(list @t)] args=(list [key=@t value=@t])]
  (fall (rush url ;~(plug apat:de-purl:html yque:de-purl:html)) [[~ ~] ~])
::
++  example-patch
'''
setInterval(() => {
  const spans = document.querySelectorAll('div > span[title^="~"][cursor="pointer"]');
  spans.forEach((span) => {
    let title = span.getAttribute('title');
    if (span.innerHTML.indexOf(title) === -1) {
      span.innerHTML = span.innerHTML + ' ' + title;
    }

    // console.log(span.innerHTML);
  });
}, 100);

let p = document.createElement('p');
p.innerHTML = "You are great";
p.style.position = 'absolute';
p.style.top = '0';
p.style.backgroundColor = "white";
document.body.appendChild(p);
'''
--
