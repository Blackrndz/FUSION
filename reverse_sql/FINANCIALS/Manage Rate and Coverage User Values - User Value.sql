/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=BEN_TYPES
 
SELECT rateCvgsE0.NAME RES_NAME
,valuesE0.TYPE_NUM RES_VALUE_CODE
,valuesE0.MEANING RES_MEANING
,DECODE(valuesE0.ACTIVE_FLAG,'Y','Yes','No') RES_ACTIVE
,valuesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,valuesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,valuesE0.CREATED_BY RSC_CREATED_BY
,valuesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,rateCvgsE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_TYPES rateCvgsE0
,BEN_TYPE_VALUES valuesE0
WHERE rateCvgsE0.TYPE_ID = valuesE0.TYPE_ID
ORDER BY rateCvgsE0.NAME
,valuesE0.TYPE_NUM