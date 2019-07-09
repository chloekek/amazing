{stdenv, makeWrapper, perl, rakudo}:
stdenv.mkDerivation {
    name = "veriety";
    src = stdenv.lib.cleanSource ./..;
    buildInputs = [makeWrapper rakudo];
    phases = ["unpackPhase" "installPhase"];
    installPhase = ''
        mkdir --parents $out/bin $out/share/doc

        cp --recursive bin lib t $out/share

        for src in $(find $out/share/lib -type f -name '*.pm6' -printf '%P\n')
        do
            HOME=$PWD PERL6LIB=$out/share/lib \
                perl6 --doc "$out/share/lib/$src" \
                    > $out/share/doc/$(sed 's:/:-:g' <<< ''${src%.pm6}.txt)
        done

        makeWrapper \
            ${rakudo}/bin/perl6 \
            $out/bin/veriety \
            --prefix PERL6LIB , $out/share/lib \
            --add-flags $out/share/bin/veriety

        makeWrapper \
            ${perl}/bin/prove \
            $out/bin/veriety.test \
            --prefix PERL6LIB , $out/share/lib \
            --add-flags --exec \
            --add-flags ${rakudo}/bin/perl6 \
            --add-flags --recurse \
            --add-flags $out/share/t
    '';
}
