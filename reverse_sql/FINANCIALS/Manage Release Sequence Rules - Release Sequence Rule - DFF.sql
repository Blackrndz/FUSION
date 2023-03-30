/* ****************************************************************************
 * $Revision: 56651 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-07-12 11:49:53 +0700 (Tue, 12 Jul 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Payment%20Terms%20-%20Installments.sql $:
 * $Id: Manage Payment Terms - Installments.sql 56651 2016-07-12 04:49:53Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=WSH_PICK_SEQUENCE_RULES_VL

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=665##RES##WSH_PICK_SEQUENCE_RULES
-- DFF_ATTRIBUTES=ATTRIBUTE,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE,ATTRIBUTE_TIMESTAMP

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT WshPickSequenceRules.PICK_SEQUENCE_RULE_NAME RES_NAME
,WshPickSequenceRules.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,WshPickSequenceRules.ATTRIBUTE1
,WshPickSequenceRules.ATTRIBUTE2
,WshPickSequenceRules.ATTRIBUTE3
,WshPickSequenceRules.ATTRIBUTE4
,WshPickSequenceRules.ATTRIBUTE5
,WshPickSequenceRules.ATTRIBUTE6
,WshPickSequenceRules.ATTRIBUTE7
,WshPickSequenceRules.ATTRIBUTE8
,WshPickSequenceRules.ATTRIBUTE9
,WshPickSequenceRules.ATTRIBUTE10
,WshPickSequenceRules.ATTRIBUTE11
,WshPickSequenceRules.ATTRIBUTE12
,WshPickSequenceRules.ATTRIBUTE13
,WshPickSequenceRules.ATTRIBUTE14
,WshPickSequenceRules.ATTRIBUTE15
,WshPickSequenceRules.ATTRIBUTE_NUMBER1
,WshPickSequenceRules.ATTRIBUTE_NUMBER2
,WshPickSequenceRules.ATTRIBUTE_NUMBER3
,WshPickSequenceRules.ATTRIBUTE_NUMBER4
,WshPickSequenceRules.ATTRIBUTE_NUMBER5
,WshPickSequenceRules.ATTRIBUTE_NUMBER6
,WshPickSequenceRules.ATTRIBUTE_NUMBER7
,WshPickSequenceRules.ATTRIBUTE_NUMBER8
,WshPickSequenceRules.ATTRIBUTE_NUMBER9
,WshPickSequenceRules.ATTRIBUTE_NUMBER10
,TO_CHAR(WshPickSequenceRules.ATTRIBUTE_DATE1,'DD-Mon-YYYY') ATTRIBUTE_DATE1
,TO_CHAR(WshPickSequenceRules.ATTRIBUTE_DATE2,'DD-Mon-YYYY') ATTRIBUTE_DATE2
,TO_CHAR(WshPickSequenceRules.ATTRIBUTE_DATE3,'DD-Mon-YYYY') ATTRIBUTE_DATE3
,TO_CHAR(WshPickSequenceRules.ATTRIBUTE_DATE4,'DD-Mon-YYYY') ATTRIBUTE_DATE4
,TO_CHAR(WshPickSequenceRules.ATTRIBUTE_DATE5,'DD-Mon-YYYY') ATTRIBUTE_DATE5
,WshPickSequenceRules.ATTRIBUTE_TIMESTAMP1
,WshPickSequenceRules.ATTRIBUTE_TIMESTAMP2
,WshPickSequenceRules.ATTRIBUTE_TIMESTAMP3
,WshPickSequenceRules.ATTRIBUTE_TIMESTAMP4
,WshPickSequenceRules.ATTRIBUTE_TIMESTAMP5
,WshPickSequenceRules.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,WshPickSequenceRules.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,WshPickSequenceRules.CREATED_BY  RSC_CREATED_BY
,WshPickSequenceRules.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WSH_PICK_SEQUENCE_RULES_VL WshPickSequenceRules
WHERE (WshPickSequenceRules.ATTRIBUTE_CATEGORY IS NOT NULL OR
WshPickSequenceRules.ATTRIBUTE1 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE2 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE3 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE4 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE5 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE6 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE7 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE8 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE9 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE10 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE11 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE12 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE13 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE14 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE15 IS NOT NULL OR
WshPickSequenceRules.ATTRIBUTE_NUMBER1 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_NUMBER2 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_NUMBER3 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_NUMBER4 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_NUMBER5 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_NUMBER6 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_NUMBER7 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_NUMBER8 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_NUMBER9 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_NUMBER10 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_DATE1 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_DATE2 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_DATE3 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_DATE4 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_DATE5 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_TIMESTAMP1 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_TIMESTAMP2 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_TIMESTAMP3 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_TIMESTAMP4 IS NOT NULL OR 
WshPickSequenceRules.ATTRIBUTE_TIMESTAMP5 IS NOT NULL)
ORDER BY WshPickSequenceRules.PICK_SEQUENCE_RULE_NAME