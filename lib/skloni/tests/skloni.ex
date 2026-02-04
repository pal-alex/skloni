defmodule Skloni.Tests.Skloni do
  @moduledoc false
  alias Skloni.Tests.Skloni.Mnozhina

  def tasks do
    [
      {"skloni", 1, "{1} Lep[] fant[] pride[].", "ednina, moški spol, imenovalnik"},
      {"skloni", 2, "{1} Lep[a] prijatelic[a] pride[].", "ednina, ženski spol, imenovalnik"},
      {"skloni", 3, "{1} Ljubljana je zelo lep[o] mest[o].", "ednina, srednji spol, imenovalnik"},
      {"skloni", 4, "Dv[a] lep[a] fant[a] pride[ta].", "dvojina, moški spol, imenovalnik"},
      {"skloni", 5, "Dv[e] lep[i] prijatelic[i] pride[ta].", "dvojina, ženski spol, imenovalnik"},
      {"skloni", 6, "Dv[e] nov[i] stanovanj[i] zgrajeni.", "dvojina, srednji spol, imenovalnik"},
      {"skloni", 10, "{1} Brez dobr[ega] fant[a] ni dneva.", "ednina, moški spol, rodilnik"},
      {"skloni", 11, "{1} Brez dobr[e] prijatelic[e] ni dneva.", "ednina, ženski spol, rodilnik"},
      {"skloni", 12, "{1} Brez dobr[ega] mest[a] ni dneva.", "ednina, srednji spol, rodilnik"},
      {"skloni", 13, "{2} Brez dobr[ih] fant[ov] ni večera.", "dvojina, moški spol, rodilnik"},
      {"skloni", 14, "{2} Brez dobr[ih] prijatelic[] ni večera.",
       "dvojina, ženski spol, rodilnik"},
      {"skloni", 15, "{2} Brez dobr[ih] mest[] ni večera.", "dvojina, srednji spol, rodilnik"},
      {"skloni", 19, "{1} K dobr[emu] fant[u] grem.", "ednina, moški spol, dajalnik"},
      {"skloni", 20, "{1} K dobr[i] prijatelic[i] grem.", "ednina, ženski spol, dajalnik"},
      {"skloni", 21, "{1} K dobr[emu] mest[u] grem.", "ednina, srednji spol, dajalnik"},
      {"skloni", 22, "{2} K dobr[ima] fant[oma] greva.", "dvojina, moški spol, dajalnik"},
      {"skloni", 23, "{2} K dobr[ima] prijatelic[ama] greva.", "dvojina, ženski spol, dajalnik"},
      {"skloni", 24, "{2} K dobr[ima] mest[oma] greva.", "dvojina, srednji spol, dajalnik"},
      {"skloni", 28, "{1} Vidim dobr[ega] fant[a].", "ednina, moški spol, tožilnik"},
      {"skloni", 29, "{1} Vidim dobr[o] prijatelic[o].", "ednina, ženski spol, tožilnik"},
      {"skloni", 30, "{1} Vidim dobr[o] mest[o].", "ednina, srednji spol, tožilnik"},
      {"skloni", 31, "{2} Vidim dv[a] dobr[a] fant[a].", "dvojina, moški spol, tožilnik"},
      {"skloni", 32, "{2} Vidim dv[e] dobr[i] prijatelic[i].", "dvojina, ženski spol, tožilnik"},
      {"skloni", 33, "{2} Vidim dv[e] dobr[i] mest[i].", "dvojina, srednji spol, tožilnik"},
      {"skloni", 37, "{1} O dobr[em] fant[u] govorim.", "ednina, moški spol, mestnik"},
      {"skloni", 38, "{1} O dobr[i] prijatelic[i] govorim.", "ednina, ženski spol, mestnik"},
      {"skloni", 39, "{1} O dobr[em] mest[u] govorim.", "ednina, srednji spol, mestnik"},
      {"skloni", 40, "Roman v dv[eh] velik[ih] del[ih]", "dvojina, moški spol, mestnik"},
      {"skloni", 41, "O dv[eh] dobr[ih] prijatelic[ah] govoriva.",
       "dvojina, ženski spol, mestnik"},
      {"skloni", 42, "O dv[eh] dobr[ih] mest[ih] govoriva.", "dvojina, srednji spol, mestnik"},
      {"skloni", 46, "{1} Z dobr[im] fant[om] grem.", "ednina, moški spol, orodnik"},
      {"skloni", 47, "{1} Z dobr[o] prijatelic[o] grem.", "ednina, ženski spol, orodnik"},
      {"skloni", 48, "{1} Z dobr[im] občutj[em] grem.", "ednina, srednji spol, orodnik"},
      {"skloni", 49, "{2} Z dobr[ima] fant[oma] greva.", "dvojina, moški spol, orodnik"},
      {"skloni", 50, "{2} Z dobr[ima] prijatelic[ama] greva.", "dvojina, ženski spol, orodnik"},
      {"skloni", 51, "{2} Z dobr[ima] orodj[ema] greva.", "dvojina, srednji spol, orodnik"}
    ] ++ Mnozhina.tasks()
  end
end
