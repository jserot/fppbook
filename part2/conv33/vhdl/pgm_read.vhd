library ieee;
use ieee.std_logic_1164.all;	   
use std.textio.all;
use ieee.numeric_std.all;

entity pgm_read is
    generic (
      filename: string;
      pixel_depth: positive;
      line_blanking: integer := 0;
      inter_frame: integer := 0;
      repeat: positive := 1
      );
    port (
      clk: in std_logic;
      rst: in std_logic;
      data: out unsigned(pixel_depth-1 downto 0);
      fval: out std_logic;
      dval: out std_logic
      );
end entity;

architecture beh of pgm_read is
begin
  process
    type fmt_t is array (1 to 3) of integer; -- Format
    variable fmt : fmt_t; 
    file pgmfile : text;
    variable width, height, maxv : positive;
    variable l : line;
    variable s : string(1 to 2);
    variable p : integer; 
    variable good : boolean; 
    variable count : positive; 
    variable x, y : natural; -- Compteurs colonne et ligne

begin
    for i in 1 to repeat loop
      -- assert false report "Opening " & filename severity warning;
      -- Ouverture fichier
      file_open(pgmfile, filename, read_mode);
      readline(pgmfile, l);
      fval <= '0';
      dval <= '0';
      -- Lecture du format
      read(l, s(1));
      read(l, s(2), good);
      assert ( good and s= "P2" )
        report "PGM file '"&filename&"' not P2 type" severity error;
      count := 1;
      fmt_reading: loop
         -- Lecture de l'entete (3 entiers)
        line_reading: loop
          readline(pgmfile, l);
          exit when l.all(1) = '#'; -- Commentaires;
          assert ( l'length /= 0 )
            report "EOF reached in pgmfile before opening integers found" severity error;
          number_reading: loop
            read(l, fmt(count), good);
            exit number_reading when not good; 
            count := count + 1;
            exit fmt_reading when count > fmt'high;
          end loop;
        end loop;
        exit when count > fmt'high;
      end loop;
     -- Decodage de l'entete
      width := fmt(1);
      height := fmt(2);
      maxv := fmt(3);
      -- Inter trame
      for cnt in 1 to inter_frame loop
        wait until rising_edge(clk);
      end loop;
      -- Lecture des pixels
      x := 0;
      y := 0;
      fval <= '1';
      allpixels: loop
        readline(pgmfile, l);
        exit when l = null; -- Aie..
        exit when l'length = 0; -- Ouille..
        numbers: loop
          read(l, p, good);
          exit numbers when not good;
          dval <= '1';
          data <= to_unsigned(p, pixel_depth);
          exit allpixels when x = width-1 and y = height-1;
          -- Increment des compteurs
          x := x + 1;
          if x >= width then -- Fin de ligne
            x := 0;
            y := y + 1;
            -- Inter ligne
            if ( line_blanking > 0 ) then 
              for i in 0 to line_blanking-1 loop
                wait until rising_edge(clk);  
                dval <= '0';
                data <= (others => '0');
              end loop;
            end if;
          end if;
          wait until rising_edge(clk);
        end loop numbers;
      end loop allpixels;
      wait until rising_edge(clk);
      dval <= '0';
      fval <= '0';
      data <= (others => '0');
      assert ( x = width-1 and y = height-1 )
        report "Missing pixel ?" severity warning;
      -- Fermeture fichier
      file_close(pgmfile);
      -- assert false report "Closing file" severity warning;
    end loop;
    wait;
  end process;
end;
