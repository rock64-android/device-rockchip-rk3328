#!/system/bin/busybox sh

map_irqs() {
	aff="$1"
	shift
	for name in $@; do
		for irq in $(busybox awk -F":" "/$name/ {print \$1}" </proc/interrupts | busybox sed 's/\ //g'); do
			echo $aff > "/proc/irq/$irq/smp_affinity"
		done
	done	
}

map_irqs 2 ehci ohci dwc_otg dw-mci
map_irqs 4 xhci
map_irqs 8 eth0
