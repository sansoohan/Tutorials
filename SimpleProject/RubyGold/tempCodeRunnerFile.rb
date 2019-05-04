module M1; end
module M2
    include M1 # this is not working
end

module M3
    prepend M1
    include M2
    module_function
    def static_builder
        "builder for M"
    end
end

p M3.ancestors
p M3.static_builder