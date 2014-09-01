require 'chaltron/version'

module Chaltron
  class Banner
    def initialize
      @banners = populate_banners
    end

    def sample(version = true)
      ret = @banners.sample
      ret = ret.chomp.+ "v.#{Chaltron::VERSION}\n" if version
      ret
    end

    def octal
      '103 150 141 154 164 162 157 156'
    end

    def binary
      '01000011 01101000 01100001 01101100 01110100 01110010 01101111 01101110'
    end

    def hex
      '43 68 61 6C 74 72 6F 6E'
    end

    def morse
      '-.-. .... .- .-.. - .-. --- -.'
    end

    private

    def populate_banners
      ret = []

      ret << <<-'END'
_________ .__           .__   __
\_   ___ \|  |__ _____  |  |_/  |________  ____   ____
/    \  \/|  |  \\__  \ |  |\   __\_  __ \/  _ \ /    \
\     \___|   Y  \/ __ \|  |_|  |  |  | \(  <_> )   |  \
 \______  /___|  (____  /____/__|  |__|   \____/|___|  /
        \/     \/     \/                             \/
      END

      ret << <<-'END'
   ___   _              .    .
 .'   \ /        ___   |   _/_   .___    __.  , __
 |      |,---.  /   `  |    |    /   \ .'   \ |'  `.
 |      |'   ` |    |  |    |    |   ' |    | |    |
  `.__, /    | `.__/| /\__  \__/ /      `._.' /    |
      END
      ret << <<-'END'
..####...##..##...####...##......######..#####....####...##..##.
.##..##..##..##..##..##..##........##....##..##..##..##..###.##.
.##......######..######..##........##....#####...##..##..##.###.
.##..##..##..##..##..##..##........##....##..##..##..##..##..##.
..####...##..##..##..##..######....##....##..##...####...##..##.
................................................................
      END

      ret << <<-'END'
  _______ __          __ __
 |   _   |  |--.---.-|  |  |_.----.-----.-----.
 |.  1___|     |  _  |  |   _|   _|  _  |     |
 |.  |___|__|__|___._|__|____|__| |_____|__|__|
 |:  1   |
 |::.. . |
 `-------'
      END

      ret << <<-'END'
   ____ _           _ _
  / ___| |__   __ _| | |_ _ __ ___  _ __
 | |   | '_ \ / _` | | __| '__/ _ \| '_ \
 | |___| | | | (_| | | |_| | | (_) | | | |
  \____|_| |_|\__,_|_|\__|_|  \___/|_| |_|
      END

      ret << <<-'END'
   ___  _            _
  / (_)| |          | |
 |     | |     __,  | |_|_  ,_    __   _  _
 |     |/ \   /  |  |/  |  /  |  /  \_/ |/ |
  \___/|   |_/\_/|_/|__/|_/   |_/\__/   |  |_/
      END

      ret << <<-'END'
  ____  _  __  _ _____ ___  __  __  _
 / _/ || |/  \| |_   _| _ \/__\|  \| |
| \_| >< | /\ | |_| | | v / \/ | | ' |
 \__/_||_|_||_|___|_| |_|_\\__/|_|\__|
      END

      ret << <<-'END'
   (       )        (     )
   )\   ( /(     )  )\ ( /( (
 (((_)  )\()) ( /( ((_))\()))(    (    (
 )\___ ((_)\  )(_)) _ (_))/(()\   )\   )\ )
((/ __|| |(_)((_)_ | || |_  ((_) ((_) _(_/(
 | (__ | ' \ / _` || ||  _|| '_|/ _ \| ' \))
  \___||_||_|\__,_||_| \__||_|  \___/|_||_|
      END

      ret << <<-'END'

 ,-----.,--.             ,--.  ,--.
'  .--./|  ,---.  ,--,--.|  |,-'  '-.,--.--. ,---. ,--,--,
|  |    |  .-.  |' ,-.  ||  |'-.  .-'|  .--'| .-. ||      \
'  '--'\|  | |  |\ '-'  ||  |  |  |  |  |   ' '-' '|  ||  |
 `-----'`--' `--' `--`--'`--'  `--'  `--'    `---' `--''--'
      END
      ret << <<-'END'
   ____ _           _ _
  / ___| |__   __ _| | |_ _ __ ___  _ __
 | |   | '_ \ / _` | | __| '__/ _ \| '_ \
 | |___| | | | (_| | | |_| | | (_) | | | |
  \____|_| |_|\__,_|_|\__|_|  \___/|_| |_|
      END

      ret << <<-'END'
   ___    _                 _      _
  / __|  | |_     __ _     | |    | |_      _ _    ___    _ _
 | (__   | ' \   / _` |    | |    |  _|    | '_|  / _ \  | ' \
  \___|  |_||_|  \__,_|   _|_|_   _\__|   _|_|_   \___/  |_||_|
_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|
"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'
      END

      ret << <<-'END'
   ______  __              __   _
 .' ___  |[  |            [  | / |_
/ .'   \_| | |--.   ,--.   | |`| |-'_ .--.   .--.   _ .--.
| |        | .-. | `'_\ :  | | | | [ `/'`\]/ .'`\ \[ `.-. |
\ `.___.'\ | | | | // | |, | | | |, | |    | \__. | | | | |
 `.____ .'[___]|__]\'-;__/[___]\__/[___]    '.__.' [___||__]
      END

      ret
    end
  end
end
