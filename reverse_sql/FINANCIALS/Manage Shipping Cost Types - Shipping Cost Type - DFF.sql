/* ****************************************************************************
 * $Revision: 55675 $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2016-12-23  $:
 * $HeadURL:$:
 * $Id: Manage Contact Lookups - Lookup Codes - DFF.sql$:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=665##RES##WSH_FREIGHT_COST_TYPES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.
 
SELECT WshFreightCostTypes.FREIGHT_COST_NAME RES_NAME
,WshFreightCostTypes.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,WshFreightCostTypes.ATTRIBUTE1
,WshFreightCostTypes.ATTRIBUTE2
,WshFreightCostTypes.ATTRIBUTE3
,WshFreightCostTypes.ATTRIBUTE4
,WshFreightCostTypes.ATTRIBUTE5
,WshFreightCostTypes.ATTRIBUTE6
,WshFreightCostTypes.ATTRIBUTE7
,WshFreightCostTypes.ATTRIBUTE8
,WshFreightCostTypes.ATTRIBUTE9
,WshFreightCostTypes.ATTRIBUTE10
,WshFreightCostTypes.ATTRIBUTE11
,WshFreightCostTypes.ATTRIBUTE12
,WshFreightCostTypes.ATTRIBUTE13
,WshFreightCostTypes.ATTRIBUTE14
,WshFreightCostTypes.ATTRIBUTE15
,WshFreightCostTypes.ATTRIBUTE_NUMBER1
,WshFreightCostTypes.ATTRIBUTE_NUMBER2
,WshFreightCostTypes.ATTRIBUTE_NUMBER3
,WshFreightCostTypes.ATTRIBUTE_NUMBER4
,WshFreightCostTypes.ATTRIBUTE_NUMBER5
,WshFreightCostTypes.ATTRIBUTE_NUMBER6
,WshFreightCostTypes.ATTRIBUTE_NUMBER7
,WshFreightCostTypes.ATTRIBUTE_NUMBER8
,WshFreightCostTypes.ATTRIBUTE_NUMBER9
,WshFreightCostTypes.ATTRIBUTE_NUMBER10
,TO_CHAR(WshFreightCostTypes.ATTRIBUTE_DATE1,'DD-Mon-YYYY') ATTRIBUTE_DATE1
,TO_CHAR(WshFreightCostTypes.ATTRIBUTE_DATE2,'DD-Mon-YYYY') ATTRIBUTE_DATE2
,TO_CHAR(WshFreightCostTypes.ATTRIBUTE_DATE3,'DD-Mon-YYYY') ATTRIBUTE_DATE3
,TO_CHAR(WshFreightCostTypes.ATTRIBUTE_DATE4,'DD-Mon-YYYY') ATTRIBUTE_DATE4
,TO_CHAR(WshFreightCostTypes.ATTRIBUTE_DATE5,'DD-Mon-YYYY') ATTRIBUTE_DATE5
,WshFreightCostTypes.ATTRIBUTE_TIMESTAMP1
,WshFreightCostTypes.ATTRIBUTE_TIMESTAMP2
,WshFreightCostTypes.ATTRIBUTE_TIMESTAMP3
,WshFreightCostTypes.ATTRIBUTE_TIMESTAMP4
,WshFreightCostTypes.ATTRIBUTE_TIMESTAMP5
,WshFreightCostTypes.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,WshFreightCostTypes.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,WshFreightCostTypes.CREATED_BY RSC_CREATED_BY
,WshFreightCostTypes.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WSH_FREIGHT_COST_TYPES WshFreightCostTypes
WHERE(WshFreightCostTypes.ATTRIBUTE_CATEGORY IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE1            IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE2            IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE3            IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE4            IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE5            IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE6            IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE7            IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE8            IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE9            IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE10           IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE11           IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE12           IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE13           IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE14           IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE15           IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_NUMBER1     IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_NUMBER2     IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_NUMBER3     IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_NUMBER4     IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_NUMBER5     IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_NUMBER6     IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_NUMBER7     IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_NUMBER8     IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_NUMBER9     IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_NUMBER10    IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_DATE1       IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_DATE2       IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_DATE3       IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_DATE4       IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_DATE5       IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_TIMESTAMP1  IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_TIMESTAMP2  IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_TIMESTAMP3  IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_TIMESTAMP4  IS NOT NULL
OR WshFreightCostTypes.ATTRIBUTE_TIMESTAMP5  IS NOT NULL)
ORDER BY WshFreightCostTypes.FREIGHT_COST_NAME