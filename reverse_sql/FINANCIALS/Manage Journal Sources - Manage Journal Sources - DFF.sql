/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Journal%20Sources%20-%20Manage%20Journal%20Sources%20-%20DFF.sql $:
 * $Id: Manage Journal Sources - Manage Journal Sources - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=101##RES##GL_JE_SOURCES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.
 
select JOURNALSOURCEEO.User_JE_SOURCE_NAME RES_NAME
,JOURNALSOURCEEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,JOURNALSOURCEEO.ATTRIBUTE1 
,JOURNALSOURCEEO.ATTRIBUTE2
,JOURNALSOURCEEO.ATTRIBUTE3
,JOURNALSOURCEEO.ATTRIBUTE4
,JOURNALSOURCEEO.ATTRIBUTE5
,JOURNALSOURCEEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,JOURNALSOURCEEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,JOURNALSOURCEEO.CREATED_BY  RSC_CREATED_BY
,JOURNALSOURCEEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 

from GL_JE_SOURCES_VL JOURNALSOURCEEO
WHERE 
JOURNALSOURCEEO.ATTRIBUTE_CATEGORY IS NOT NULL OR
JOURNALSOURCEEO.ATTRIBUTE1 IS NOT NULL OR 
JOURNALSOURCEEO.ATTRIBUTE2 IS NOT NULL OR 
JOURNALSOURCEEO.ATTRIBUTE3 IS NOT NULL OR 
JOURNALSOURCEEO.ATTRIBUTE4 IS NOT NULL OR 
JOURNALSOURCEEO.ATTRIBUTE5 IS NOT NULL
order by RES_NAME