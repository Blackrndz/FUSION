/* ****************************************************************************
 * $Revision:  $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2017-04-25 $:
 * $HeadURL:  $:
 * $Id: Manage Shipping Parameters - Shipping Parameters - DFF.sql $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=665##RES##WSH_SHIPPING_PARAMETERS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields. 

SELECT
 WshShippingParametersEO.ORGANIZATION_CODE                          RES_ORGANIZATION
,WshShippingParametersEO.ATTRIBUTE_CATEGORY 						RES_CONTEXT_CODE
,WshShippingParametersEO.ATTRIBUTE1
,WshShippingParametersEO.ATTRIBUTE2
,WshShippingParametersEO.ATTRIBUTE3
,WshShippingParametersEO.ATTRIBUTE4
,WshShippingParametersEO.ATTRIBUTE5
,WshShippingParametersEO.ATTRIBUTE6
,WshShippingParametersEO.ATTRIBUTE7
,WshShippingParametersEO.ATTRIBUTE8
,WshShippingParametersEO.ATTRIBUTE9
,WshShippingParametersEO.ATTRIBUTE10
,WshShippingParametersEO.ATTRIBUTE11
,WshShippingParametersEO.ATTRIBUTE12
,WshShippingParametersEO.ATTRIBUTE13
,WshShippingParametersEO.ATTRIBUTE14
,WshShippingParametersEO.ATTRIBUTE15
,WshShippingParametersEO.LAST_UPDATED_BY 		RSC_LAST_UPDATED_BY
,WshShippingParametersEO.LAST_UPDATE_DATE 		RSC_LAST_UPDATE_DATE
,WshShippingParametersEO.CREATED_BY 			RSC_CREATED_BY
,WshShippingParametersEO.CREATION_DATE 			RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,WshShippingParametersEO.ORGANIZATION_ID  		RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WSH_SHIPPING_PARAMETERS WshShippingParametersEO
WHERE(WshShippingParametersEO.ATTRIBUTE_CATEGORY IS NOT NULL
OR WshShippingParametersEO.ATTRIBUTE1            IS NOT NULL
OR WshShippingParametersEO.ATTRIBUTE2            IS NOT NULL
OR WshShippingParametersEO.ATTRIBUTE3            IS NOT NULL
OR WshShippingParametersEO.ATTRIBUTE4            IS NOT NULL
OR WshShippingParametersEO.ATTRIBUTE5            IS NOT NULL
OR WshShippingParametersEO.ATTRIBUTE6            IS NOT NULL
OR WshShippingParametersEO.ATTRIBUTE7            IS NOT NULL
OR WshShippingParametersEO.ATTRIBUTE8            IS NOT NULL
OR WshShippingParametersEO.ATTRIBUTE9            IS NOT NULL
OR WshShippingParametersEO.ATTRIBUTE10           IS NOT NULL
OR WshShippingParametersEO.ATTRIBUTE11           IS NOT NULL
OR WshShippingParametersEO.ATTRIBUTE12           IS NOT NULL
OR WshShippingParametersEO.ATTRIBUTE13           IS NOT NULL
OR WshShippingParametersEO.ATTRIBUTE14           IS NOT NULL
OR WshShippingParametersEO.ATTRIBUTE15           IS NOT NULL
)
