/* ****************************************************************************
 * $Revision: 61996 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2017-05-02 17:46:19 +0700 (Tue, 02 May 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Procurement%20Agents%20-%20Procurement%20Agents%20-%20DFF.sql $:
 * $Id: Manage Procurement Agents - Procurement Agents - DFF.sql 61996 2017-05-02 10:46:19Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=665##RES##WSH_PICKING_RULES
-- DFF_ATTRIBUTES=ATTRIBUTE,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE,ATTRIBUTE_TIMESTAMP

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT WshPickingRules.PICKING_RULE_NAME RES_NAME
,WshPickingRules.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,WshPickingRules.ATTRIBUTE1
,WshPickingRules.ATTRIBUTE2
,WshPickingRules.ATTRIBUTE3
,WshPickingRules.ATTRIBUTE4
,WshPickingRules.ATTRIBUTE5
,WshPickingRules.ATTRIBUTE6
,WshPickingRules.ATTRIBUTE7
,WshPickingRules.ATTRIBUTE8
,WshPickingRules.ATTRIBUTE9
,WshPickingRules.ATTRIBUTE10
,WshPickingRules.ATTRIBUTE11
,WshPickingRules.ATTRIBUTE12
,WshPickingRules.ATTRIBUTE13
,WshPickingRules.ATTRIBUTE14
,WshPickingRules.ATTRIBUTE15
,WshPickingRules.ATTRIBUTE_NUMBER1
,WshPickingRules.ATTRIBUTE_NUMBER2
,WshPickingRules.ATTRIBUTE_NUMBER3
,WshPickingRules.ATTRIBUTE_NUMBER4
,WshPickingRules.ATTRIBUTE_NUMBER5
,WshPickingRules.ATTRIBUTE_NUMBER6
,WshPickingRules.ATTRIBUTE_NUMBER7
,WshPickingRules.ATTRIBUTE_NUMBER8
,WshPickingRules.ATTRIBUTE_NUMBER9
,WshPickingRules.ATTRIBUTE_NUMBER10
, TO_CHAR(WshPickingRules.ATTRIBUTE_DATE1, 'DD-Mon-YYYY') ATTRIBUTE_DATE1
, TO_CHAR(WshPickingRules.ATTRIBUTE_DATE2, 'DD-Mon-YYYY') ATTRIBUTE_DATE2
, TO_CHAR(WshPickingRules.ATTRIBUTE_DATE3, 'DD-Mon-YYYY') ATTRIBUTE_DATE3
, TO_CHAR(WshPickingRules.ATTRIBUTE_DATE4, 'DD-Mon-YYYY') ATTRIBUTE_DATE4
, TO_CHAR(WshPickingRules.ATTRIBUTE_DATE5, 'DD-Mon-YYYY') ATTRIBUTE_DATE5
,WshPickingRules.ATTRIBUTE_TIMESTAMP1
,WshPickingRules.ATTRIBUTE_TIMESTAMP2
,WshPickingRules.ATTRIBUTE_TIMESTAMP3
,WshPickingRules.ATTRIBUTE_TIMESTAMP4
,WshPickingRules.ATTRIBUTE_TIMESTAMP5
,WshPickingRules.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,WshPickingRules.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,WshPickingRules.CREATED_BY RSC_CREATED_BY
,WshPickingRules.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,WshPickingRules.ORGANIZATION_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WSH_PICKING_RULES WshPickingRules
WHERE (WshPickingRules.ATTRIBUTE_CATEGORY IS NOT NULL OR
WshPickingRules.ATTRIBUTE1 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE2 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE3 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE4 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE5 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE6 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE7 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE8 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE9 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE10 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE11 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE12 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE13 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE14 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE15 IS NOT NULL OR
WshPickingRules.ATTRIBUTE_NUMBER1 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE_NUMBER2 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE_NUMBER3 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE_NUMBER4 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE_NUMBER5 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE_NUMBER6 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE_NUMBER7 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE_NUMBER8 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE_NUMBER9 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE_NUMBER10 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE_DATE1 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE_DATE2 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE_DATE3 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE_DATE4 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE_DATE5 IS NOT NULL OR
WshPickingRules.ATTRIBUTE_TIMESTAMP1 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE_TIMESTAMP2 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE_TIMESTAMP3 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE_TIMESTAMP4 IS NOT NULL OR 
WshPickingRules.ATTRIBUTE_TIMESTAMP5 IS NOT NULL)
ORDER BY WshPickingRules.PICKING_RULE_NAME