#!/bin/bash

# CTF Team Logo Display Script v3
# Red-themed minimal design

# Color definitions
RED='\033[0;31m'
BRIGHT_RED='\033[1;31m'
DARK_RED='\033[2;31m'
WHITE='\033[1;37m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

# Glitch effect configuration
GLITCH_ENABLED=false

# Matrix rain effect (red themed)
matrix_rain() {
    local duration=1
    local end=$((SECONDS + duration))
    
    while [ $SECONDS -lt $end ]; do
        printf "${RED}"
        for ((i=0; i<$COLUMNS; i++)); do
            printf "%d" $((RANDOM % 2))
        done
        printf "${NC}\n"
        sleep 0.04
    done
}

# Color mapping for skull characters - red themed
colorize_line() {
    local line="$1"
    local colored_line=""
    
    for ((i=0; i<${#line}; i++)); do
        char="${line:$i:1}"
        case "$char" in
            "@")  # Main skull character - bright red
                if $GLITCH_ENABLED && [ $((RANDOM % 30)) -eq 0 ]; then
                    colored_line+="${WHITE}${char}${NC}"
                else
                    colored_line+="${RED}${char}${NC}"
                fi
                ;;
            [+\#\%\=\:\-\*\.])  # Detail characters - various red shades
                colored_line+="${DARK_RED}${char}${NC}"
                ;;
            " ")  # Spaces remain spaces
                colored_line+=" "
                ;;
            *)  # Any other characters
                colored_line+="${DARK_RED}${char}${NC}"
                ;;
        esac
    done
    
    echo -e "$colored_line"
}

# Scanline effect
scanline_display() {
    while IFS= read -r line; do
        colorize_line "$line"
        [ "$1" == "--slow" ] && sleep 0.03
    done
}

# Main display function
show_logo() {
    clear
    
    # Matrix effect if requested
    if [ "$1" == "--matrix" ]; then
        matrix_rain
        clear
    fi
    
    # Display the ASCII art
    cat << 'SKULL_EOF' | scanline_display "$2"
                                                                                                                 
                                         
                                                                                                                 
                             +++                                                .                                
                            @@                      @@@@-                         @@                             
                          %@  @                   @@    #@@                      @  @                            
                         =    @                  @         @@@@@@                @   @                           
                        :@   @            @@@@@@@                @@              @    @                          
                        @    @          =@                         @             @    @                          
                        @     @-        @                          @@@@@*       =@                               
                        @      @    .@@@@                               @-    *@@     @                          
                        @       @@@ %                                    @  @@@       @                          
                         @         @@                                    @ @          %                          
                         -@        @*@@@            @@@@@@@@@@@@@@@@@@@@@@ @         @                           
                           @       @@  @@      @  @@@                     %@       @@.                           
                           .@@     @@  @%      @@@                        @@      @:                             
                             -@@   @@  @@     @@                          @@   @@@                               
                                +@@ @   @@    @@                          *.@@@                                  
                                    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:%@@@@@@@@@@+                         
                                    @                            @@  @    @@            #:                       
                                    @                            @@  @    @@             @                       
                                    @                            @@  @    @.@@@@@@@      @                       
                                    @    @@@@@                @@@    @@   @        @@    @                       
                                    @    @   .@@@@         @@@    @@  @   @         @     #                      
                                    @    @       :@@@      @   @@@.@  @   @         @     @                      
                                    @    @         @       @@  @  +@  @   @         @     @                      
                                   #     @@=     @@:       @@  %  *   @    @        @     @                      
                                   @       @@@@@@@    @@@   @@     @@@     @        @     @                      
                                    @                 +  @                 @         @    @                      
                                   *@@               @@::@                @@        =@    @                      
                                   @ @@@@@@         @@@ @@@         @@@@@@ @        @     @                      
                                   @      @@@                     @@:@     @    .@@@      @                      
                                   @      @ @                     @  @     @ .@@@        @                       
                                   @      @ @    @@@   @@@  @@@@  @  @     @ @         @@                        
                                   @      @ @   @  @@  @  @  @@   @  @     @ @      @@-                          
                                  -       @ @  @@   @  @@@   @@   @  @      :@   @@@                             
                                  @       @@@   @@@@@  @     @@   @@@       @@ @@%                               
                                  @         @                     @         @.*                                  
                                  @                                         @                                    
                                 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                   
                               -@                                             @=                                 
                               @                                               @                                 
                               @                                               @                                 
                               @                                               @                                 
                               +@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@+                                 

                                                                                                                 
SKULL_EOF
    
    # Footer
    echo
    echo -e "                   ${BOLD}${RED}┌─────────────────────────────────────────────────────────────────────────────┐${NC}"
    echo -e "                   ${BOLD}${RED}│${NC} ${BOLD}${GREEN}[${NC}${BOLD}${WHITE}+${NC}${BOLD}${GREEN}]${NC} Status: ${BOLD}${RED}COMPROMISED${NC}  ${BOLD}${GREEN}[${NC}${BOLD}${WHITE}+${NC}${BOLD}${GREEN}]${NC} Mission: ${BOLD}${RED}CAPTURE FLAGS${NC}  ${BOLD}${GREEN}[${NC}${BOLD}${WHITE}+${NC}${BOLD}${GREEN}]${NC} Priority: ${BOLD}${RED}MAXIMUM${NC}  ${BOLD}${RED}│${NC}"
    echo -e "                   ${BOLD}${RED}└─────────────────────────────────────────────────────────────────────────────┘${NC}"
    echo -e "                                   ${DIM}${CYAN}>> Penetrate. Exploit. Conquer. Repeat <<${NC}"
    echo
}

# Parse arguments
case "$1" in
    -m|--matrix)
        show_logo --matrix "$2"
        ;;
    -s|--slow)
        show_logo "" --slow
        ;;
    -ms|--matrix-slow)
        show_logo --matrix --slow
        ;;
    -g|--glitch)
        GLITCH_ENABLED=true
        show_logo "" "$2"
        ;;
    -h|--help)
        echo "CTF Team Logo Display"
        echo
        echo "Usage: $0 [OPTIONS]"
        echo
        echo "Options:"
        echo "  -m, --matrix       Matrix rain effect intro (red themed)"
        echo "  -s, --slow         Slow scanline display"
        echo "  -ms, --matrix-slow Both matrix and slow display"
        echo "  -g, --glitch       Enable random glitch effects"
        echo "  -h, --help         Show this help message"
        echo
        ;;
    *)
        show_logo
        ;;
esac