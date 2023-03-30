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
,DECODE(tranParametersE0.MANDATORY_FLAG,'Y','*')||tranParametersE0.TRANSMIT_PARAMETER_NAME RES_NAME
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'IBY_PARAMETER_TYPES'
	AND LOOKUP_CODE = tranParametersE0.TRANSMIT_PARAMETER_TYPE
	) RES_DATA_TYPE
,(CASE
	WHEN tranParametersE0.SECURED_FLAG = 'N' THEN
		(CASE
		WHEN tranParametersE0.TRANSMIT_PARAMETER_TYPE = 'VARCHAR2' THEN
			tranValuesE0.TRANSMIT_VARCHAR2_VALUE
		WHEN tranParametersE0.TRANSMIT_PARAMETER_TYPE = 'NUMBER' THEN
			TO_CHAR(tranValuesE0.TRANSMIT_NUMBER_VALUE)
		ELSE
			TO_CHAR(tranValuesE0.TRANSMIT_DATE_VALUE,'DD-Mon-YYYY')
		END)
	ELSE	
		NULL
	END) RES_VALUE
,tranValuesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,tranValuesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,tranValuesE0.CREATED_BY RSC_CREATED_BY
,tranValuesE0.CREATION_DATE RSC_CREATION_DATE
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
,IBY_TRANSMIT_VALUES tranValuesE0
,IBY_TRANSMIT_PARAMETERS_VL tranParametersE0
WHERE tranConfsE0.TRANSMIT_PROTOCOL_CODE = tranProtocolsE0.TRANSMIT_PROTOCOL_CODE
AND tranConfsE0.TRANSMIT_CONFIGURATION_ID = tranValuesE0.TRANSMIT_CONFIGURATION_ID
AND tranValuesE0.TRANSMIT_PARAMETER_CODE = tranParametersE0.TRANSMIT_PARAMETER_CODE
AND tranParametersE0.TRANSMIT_PROTOCOL_CODE = tranProtocolsE0.TRANSMIT_PROTOCOL_CODE
ORDER BY DECODE(tranConfsE0.TRANSMIT_PROTOCOL_CODE,'IBY_DELIVERY_ENVELOPE',1,2)
,tranProtocolsE0.TRANSMIT_PROTOCOL_NAME
,tranConfsE0.TRANSMIT_CONFIGURATION_NAME
,tranParametersE0.TRANSMIT_PARAMETER_NAME

/*
Note

Column RES_VALUE has been added the condition to check SECURED_FLAG from table IBY_TRANSMIT_PARAMETERS_VL. If it's 'Y' the value will return as *** which it's not the correct value due to Oracle have add security to this column. 

*/