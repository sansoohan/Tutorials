require 'test/unit'
class TC_Foo < Test::Unit::TestCase
    def test_foo
        assert_equal(1,1)
    end
    def test_bar
        assert_true(true)
    end 
end