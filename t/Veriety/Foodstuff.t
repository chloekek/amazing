use Test;

use Veriety::Foodstuff;

my constant Foodstuff = Veriety::Foodstuff;

my Foodstuff:D %foodstuffs;
%foodstuffs{‘spaghetti’}       = Foodstuff.new(<pasta vegetarian>, ‘sauce’ ∈ *);
%foodstuffs{‘bolognese-sauce’} = Foodstuff.new(<meat sauce>);
%foodstuffs{‘steak’}           = Foodstuff.new(<meat>);

subtest ‘spaghetti is only compatible with sauces’ => {
    ok(%foodstuffs<spaghetti>.compatible(%foodstuffs<bolognese-sauce>.tags));
    ok(%foodstuffs<spaghetti>.incompatible(%foodstuffs<steak>.tags));
}

done-testing;
