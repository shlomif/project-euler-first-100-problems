# Copyright by Shlomi Fish, 2018 under the Expat licence
# https://opensource.org/licenses/mit-license.php

class Integer
    def continued_fraction

        states = Hash.new

        root = Math.sqrt(self).to_i
        numer = 1
        denom_in_root = self
        denom_out_of_root = -root

        make_state = lambda {
            return { 'r' => root, 'numer' => numer, 'di' => denom_in_root,
                'do' => denom_out_root,
            }
        }

        state_as_string = lambda {
            return \
            "r=#{root};n=#{numer};di=#{denom_in_root};do=#{denom_out_of_root}"
        }

        s = state_as_string.call();
        ret = []

        # has_key? is like exists() in Perl.
        while (! states.has_key?(s) )

            # Store the state appropriately.
            l = ret.length
            ret.push(root)
            states[s] = l;

            # Calculate the next state.

            # Remming out
            # # new_numer = [numer*denom_in_root, -numer*denom_out_of_root];

            new_denom = denom_in_root - denom_out_of_root*denom_out_of_root;

            if (new_denom % numer != 0)
                abort "We don't know how to handle it!"
            end

            new_denom /= numer;
            new_numer = [denom_in_root, -denom_out_of_root];

            root = ((Math.sqrt(new_numer[0]) + new_numer[1]) / new_denom).to_i;
            numer = new_denom
            denom_in_root = new_numer[0]
            denom_out_of_root = new_numer[1] - root * new_denom

            s = state_as_string.call();
        end

        pos = states[s]

        return [ret[0 .. pos-1], ret[pos .. ret.length-1]]
    end
end

