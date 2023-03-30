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
,rateCvgsE0.DESCRIPTION RES_DESCRIPTION
,DECODE(rateCvgsE0.CONFIG_CHAR_1,'Y','Yes','No') RES_ENTER_AMOUNT_AT_ENROLLMENT
,rateCvgsE0.CONFIG_NUM_1 RES_MINIMUM_VALUE
,rateCvgsE0.CONFIG_NUM_2 RES_MAXIMUM_VALUE
,rateCvgsE0.CONFIG_NUM_3 RES_INCREMENT
,rateCvgsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,rateCvgsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,rateCvgsE0.CREATED_BY RSC_CREATED_BY
,rateCvgsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,rateCvgsE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_TYPES rateCvgsE0
ORDER BY rateCvgsE0.NAME