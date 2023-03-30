/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Journal%20Sources%20-%20Manage%20Journal%20Sources.sql $:
 * $Id: Manage Journal Sources - Manage Journal Sources.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


select JOURNALSOURCEEO.USER_JE_SOURCE_NAME RES_NAME
,JOURNALSOURCEEO.JE_SOURCE_KEY RES_SOURCE_KEY
,JOURNALSOURCEEO.DESCRIPTION RES_DESCRIPTION
,DECODE(JOURNALSOURCEEO.OVERRIDE_EDITS_FLAG,'Y','Yes','N','No','Partial allow import correction only') RES_FREEZE_JOURNALS
,DECODE(JOURNALSOURCEEO.EFFECTIVE_DATE_RULE_CODE,'R','Roll Date','L','Leave Alone','Fail') RES_ACCOUNTING_DATE_RULE
,DECODE(JOURNALSOURCEEO.JOURNAL_REFERENCE_FLAG,'Y','Yes','No') RES_IMPORT_JOURNAL_REFERENCES
,DECODE(JOURNALSOURCEEO.JOURNAL_APPROVAL_FLAG,'Y','Yes','No') RES_REQUIRE_JOURNAL_APPROVAL
,DECODE(JOURNALSOURCEEO.IMPORT_USING_KEY_FLAG,'Y','Yes','No') RES_IMPORT_USING_KEY
,JournalSourceEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,JournalSourceEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,JournalSourceEO.CREATED_BY  RSC_CREATED_BY
,JournalSourceEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from GL_JE_SOURCES_VL JOURNALSOURCEEO
ORDER BY JournalSourceEO.USER_JE_SOURCE_NAME