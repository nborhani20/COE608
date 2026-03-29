library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity alu8 is
    port (
        a       : in std_logic_vector(7 downto 0);
        b       : in std_logic_vector(7 downto 0);
        op      : in std_logic_vector(2 downto 0);
        result  : out std_logic_vector(7 downto 0);
        zero    : out std_logic;
        cout    : out std_logic
    );
end alu8;

architecture Behavior of alu8 is
    component adder8
        port (
            Cin  : in std_logic;
            X, Y : in std_logic_vector(7 downto 0);
            S    : out std_logic_vector(7 downto 0);
            Cout : out std_logic
        );
    end component;

    signal result_s    : std_logic_vector(7 downto 0) := (others => '0');
    signal result_add  : std_logic_vector(7 downto 0) := (others => '0');
    signal result_sub  : std_logic_vector(7 downto 0) := (others => '0');
    signal cout_add    : std_logic := '0';
    signal cout_sub    : std_logic := '0';
	 signal cout_s      : std_logic := '0';
	 signal zero_s      : std_logic;
begin
    add0: adder8 port map (op(2), a, b, result_add, cout_add);
    sub0: adder8 port map (op(2), a, not b, result_sub, cout_sub);

    process (a, b, op)
    begin
        case op is
            when "000" =>  -- a AND b
                result_s <= a and b;
                cout_s <= '0';
            when "001" =>  -- a OR b
                result_s <= a or b;
                cout_s <= '0';
            when "010" =>  -- a + b
                result_s <= result_add;
                cout_s <= cout_add;
            when "011" =>  -- b