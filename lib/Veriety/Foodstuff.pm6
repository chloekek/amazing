unit class Veriety::Foodstuff;

has Set $.tags is required;

#| The compatible routine receives the union of the tags of all other
#| foodstuffs on the menu, and returns whether the foodstuff is compatible
#| with the other foodstuffs.
has &.compatible is required = { True };

method new(::?CLASS:U: Set() $tags, &compatible = { True } --> ::?CLASS:D)
{
    self.bless(:$tags, :&compatible);
}

method compatible(::?CLASS:D: Set:D $tags --> Bool:D)
{
    &!compatible($tags);
}

method incompatible(::?CLASS:D: Set:D $tags --> Bool:D)
{
    !self.compatible($tags);
}
