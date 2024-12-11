library ieee;
use ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock is
    port(
        clk: in std_logic;  -- 时钟源
        key_sec, key_min: in std_logic;  -- 校时设置/闹铃设置按键
        speak: out std_logic_vector(9 downto 0); --整点响铃/闹铃响铃
        sec0_led7,sec1_led7,min0_led7,min1_led7: out std_logic_vector(6 downto 0)
    );
end clock;

architecture bhv of clock is
    component diver is
        port(
            clk: in std_logic;    -- 原始时钟频率
            clk0: out std_logic;  -- 正常计时分频
            clk1: out std_logic   -- 设置闹铃和校时分频
        );
    end component;
    
    -- 秒计时器
    component count_sec is
        port(
            clk, rst, en: in std_logic;                
            q0, q1: out std_logic_vector(3 downto 0); 
            cout: out std_logic
        );
    end component;
    
    -- 分计时器
    component count_min is
        port(
            clk, rst, en: in std_logic;                
            q0, q1: out std_logic_vector(3 downto 0); 
            cout: out std_logic
        );
    end component;

    -- 校时二选一
    component mux21a is
        port( 
            a, b, s: in std_logic;
            y: out std_logic
        );
    end component;
    
    -- 报时
    component baoshi is
        port(
            min0, min1, sec0, sec1: in std_logic_vector(3 downto 0);
            speak: out std_logic
        );
    end component;
    
    -- 数码管显示
    component seg is
        port(
            a: in std_logic_vector(3 downto 0);
            led7s: out std_logic_vector(6 downto 0)
        );
    end component;



    -- 实例化部分
    signal normal_clk, fast_clk : std_logic;
    signal min_clk: std_logic;
    signal sec0_n, sec1_n, min0_n, min1_n : std_logic_vector(3 downto 0);
    signal key_sec_n, key_min_n : std_logic;
    signal speak_zd : std_logic;
    signal sec_cout, min_cout : std_logic;  -- 声明计数器溢出信号
    signal sec0_led7s,sec1_led7s,min0_led7s,min1_led7s: std_logic_vector(6 downto 0);
    -- 分频
begin
    U1: diver port map (clk => clk, clk0 => normal_clk, clk1 => fast_clk);

    -- 正常时间计数器
    U2: count_sec port map (clk => normal_clk, rst => key_sec_n, en => '1', q0 => sec0_n, q1 => sec1_n, cout => sec_cout);
    U3: count_min port map (clk => min_clk, rst => '1', en => '1', q0 => min0_n, q1 => min1_n, cout => min_cout);
    -- 校时
    U4: mux21a port map (a => fast_clk, b => sec_cout, s => key_min_n, y => min_clk);





    -- 整点检测
    U5: baoshi port map (min0 => min0_n, min1 => min1_n, sec0 => sec0_n, sec1 => sec1_n, speak => speak_zd);

    -- 数码管显示
    U6: seg port map (sec1_n, led7s => sec0_led7);
    U7: seg port map (sec0_n, led7s => sec1_led7);
    U8: seg port map (min1_n, led7s => min0_led7);
    U9: seg port map (min0_n, led7s => min1_led7);
    
    speak(0) <= speak_zd;
    speak(1) <= speak_zd;
    speak(2) <= speak_zd;
    speak(3) <= speak_zd;
    speak(4) <= speak_zd;
    speak(5) <= speak_zd;
    speak(6) <= speak_zd;
    speak(7) <= speak_zd;
    speak(8) <= speak_zd;
    speak(9) <= speak_zd;
    key_sec_n <=key_sec;
    key_min_n <=key_min;
    
    
end bhv;
