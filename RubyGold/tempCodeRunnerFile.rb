module Mod
#     def foo
#         puts "Mod"
#     end
# end
# class Cls1
#     include Mod
#     def foo
#         puts "Cls1"
#         super
#     end
# end
# class Cls2 < Cls1
#     def foo
#         puts "Cls2"
#         super
#     end
# end