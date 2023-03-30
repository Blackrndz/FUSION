/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-04-25 $:
 * $HeadURL: $:
 * $Id: Manage Lot Grades - Lot Grades.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT tranConfsE0.TRANSMIT_CONFIGURATION_NAME RES_CONFIGURATION
,tranProtocolsE0.TRANSMIT_PROTOCOL_NAME RES_PROTOCOL
,(SELECT TRANSMIT_CONFIGURATION_NAME
	FROM IBY_TRANSMIT_CONFIGS_VL
	WHERE TRANSMIT_CONFIGURATION_ID = tranConfsE0.TUNNELING_TRANS_CONFIG_ID
	) RES_TUNNELING_CONFIGURATION
,tranConfsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,tranConfsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,tranConfsE0.CREATED_BY RSC_CREATED_BY
,tranConfsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IBY_TRANSMIT_CONFIGS_VL tranConfsE0
,IBY_TRANSMIT_PROTOCOLS_VL tranProtocolsE0
WHERE tranConfsE0.TRANSMIT_PROTOCOL_CODE = tranProtocolsE0.TRANSMIT_PROTOCOL_CODE
ORDER BY DECODE(tranConfsE0.TRANSMIT_PROTOCOL_CODE,'IBY_DELIVERY_ENVELOPE',1,2)
,tranProtocolsE0.TRANSMIT_PROTOCOL_NAME
,tranConfsE0.TRANSMIT_CONFIGURATION_NAME