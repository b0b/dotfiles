cpu_freq=$(cpufreq-info -fm)
cpu_temp=$(sensors | tail -n2 | awk '{print $2}')


sbatt() {
    local STATE
    STATE=`cat /proc/acpi/battery/BAT0/state /proc/acpi/battery/BAT0/info`
    case `echo $STATE | awk '/present:/{print $2}' - | tail -n 1` in
        no)
        print -n "no"
        ;;
        *)
        echo $STATE | awk '/design capacity:/ {f=$3}; /remaining capacity:/ {r=$3}; END {print 100*r/f"%"}' -
        ;;
    esac
}

sbatt

echo $cpu_freq $cpu_temp $bat_info
