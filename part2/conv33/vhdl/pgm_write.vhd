library ieee;
use ieee.std_logic_1164.all;	   
use std.textio.all;
use ieee.numeric_std.all;

entity pgm_write is
    generic (
      filename: string;
      pixel_depth: positive;
      im_width: positive;
      im_height: positive;
      maxv: positive;
      repeat: natural := 1
      );
    port (
      clk: in std_logic;
      rst: in std_logic;
      data: in unsigned(pixel_depth-1 downto 0);
      fval: in std_logic;
      dval: in std_logic
      );
end entity;

architecture beh of pgm_write is
begin
  process
    file pgmfile : text;
    variable l   : line;
    variable fcnt : integer := 1; -- Compteur image
    variable x, y : integer; -- Compteurs colonne et ligne
  begin
    frames: loop
      -- Ouverture du fichier
      if repeat > 1 then
        file_open(pgmfile, filename & "_" & integer'image(fcnt), write_mode);
      else 
        file_open(pgmfile, filename, write_mode);
      end if;
      -- Ecriture de l'entete
      write(l, string'("P2"));
      writeline(pgmfile, l);
      write(l, integer'image(im_width) & " " & integer'image(im_height));
      writeline(pgmfile, l);
      write(l, integer'image(maxv));
      writeline(pgmfile, l);
      x := 0;
      y := 0;
      pixels: loop
        wait until rising_edge(clk);
        if fval = '1' and dval = '1' then
          -- Ecriture pixel
          write(l, integer'image(to_integer(unsigned(data))) & " ");
          writeline(pgmfile, l);
          -- Increment des compteurs
          x := x + 1;
          if x >= im_width then 
            x := 0;
            y := y + 1;
          end if;
          exit pixels when y >= im_height;
        end if;
      end loop pixels;
      fcnt := fcnt+1;
      file_close(pgmfile);
      -- Fin ou image suivante
      exit frames when repeat < 2 or fcnt > repeat;
    end loop;
    wait;   
  end process;
end;
