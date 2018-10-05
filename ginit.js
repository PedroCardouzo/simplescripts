// 'C40_W129_V130_V134_', 'C40_W129_V130_V134_V140_'
// 'C12_W37_V40_V53_', 'C12_W37_V40_V53_V59_'
// 'C14_W42_V45_V58_', 'C14_W42_V45_V58_V64_'
// 'C55_W134_V135_V139_', 'C55_W134_V135_V139_V145_'
// 'C42_W134_V135_V139_', 'C42_W134_V135_V139_V145_'

// get basic incident data from BCP
(function(incident_ID_BASIS = 'C12_W37_V40_V53_', sysid_BASIS = 'C12_W37_V40_V53_V59_'){
    wrapper = {}

	wrapper.incident_ID = document.getElementById(incident_ID_BASIS + 'btcustomerh_struct.css_object_id').getAttribute('title')
	wrapper.incident_ID = wrapper.incident_ID.split(' ')
	wrapper.incident_ID[2] = wrapper.incident_ID[2].slice(0,4)
	wrapper.url = 'https://support.wdf.sap.corp/sap/support/message/' + wrapper.incident_ID.join('')
	wrapper.incident_number = Number(wrapper.incident_ID[1]) + ' ' + wrapper.incident_ID[2]

	wrapper.name = document.getElementById(incident_ID_BASIS + 'btpartnerset_soldto_name').textContent
	wrapper.cust_number = document.getElementById(incident_ID_BASIS + 'btpartnerset_erp_number').getAttribute('title')
	wrapper.sysid = document.getElementById(sysid_BASIS + 'btcustomerh_struct.sr_sysid').textContent
	
	wrapper.data_protection = document.getElementById(sysid_BASIS + 'btadminh_dprest').textContent || null
	return JSON.stringify(wrapper)
}())
