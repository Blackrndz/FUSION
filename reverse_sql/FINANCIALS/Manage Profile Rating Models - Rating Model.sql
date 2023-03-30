/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Profile%20Rating%20Models%20-%20Rating%20Model.sql $:
 * $Id: Manage Profile Rating Models - Rating Model.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT hrtRatingModelEO.RATING_MODEL_CODE RES_CODE
 ,hrtRatingModelEO.RATING_NAME RES_NAME
 ,hrtRatingModelEO.RATING_DESCRIPTION RES_DESCRIPTION
 ,TO_CHAR(hrtRatingModelEO.DATE_FROM,'DD-Mon-YYYY') RES_FROM_DATE
 ,TO_CHAR(hrtRatingModelEO.DATE_TO,'DD-Mon-YYYY') RES_TO_DATE
 ,hrtRatingModelEO.DISTRIBUTION_THRESHOLD RES_DISTRIBUTION_THRESHOLD
 ,hrtRatingModelEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
 ,hrtRatingModelEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
 ,hrtRatingModelEO.CREATED_BY RSC_CREATED_BY
 ,hrtRatingModelEO.CREATION_DATE RSC_CREATION_DATE
 ,NULL RSC_LEDGER_ID
 ,NULL RSC_CHART_OF_ACCOUNTS_ID
 ,NULL RSC_BUSINESS_UNIT_ID
 ,NULL RSC_LEGAL_ENTITY_ID
 ,NULL RSC_ORGANIZATION_ID
 ,hrtRatingModelEO.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
 ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRT_RATING_MODELS_VL hrtRatingModelEO
ORDER BY hrtRatingModelEO.RATING_NAME
