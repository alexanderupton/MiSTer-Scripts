#!/bin/bash
# mra_sort_scan : v0.01 : Alexander Upton : 02/26/2021

# Copyright (c) 2021 Alexander Upton <alex.upton@gmail.com>
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# You can download the latest version of this script from:
# https://github.com/alexanderupton/MiSTer-Scripts

# v0.01 : Alexander Upton : 02/26/2021 : Initial Release


# ========= IMMUTABLE ================

IFS=$'\n'
OIFS="$IFS"
OPTION=${1}
SWITCH=${2}

if [ "${SWITCH}" == "-v" ]; then
  export MKDIR_OPT="-pv"
  export LN_OPT="-sfv"
else
  export MKDIR_OPT="-p"
  export LN_OPT="-sf"
fi

# ========= OPTIONS ==================

MRA_PATH="/media/fat/_Arcade"
MRA_RECENT_DIR=${MRA_PATH}/"_.Most Recent"
UPDATE_ALL_LOG="/media/fat/Scripts/.mister_updater/update_all.log"
VER="0.01"

# ========= USAGE ====================

USAGE(){
 echo
 echo "mra_sort_scan <option> <switch>"
 echo "options:"
 echo "   -bc : Create Sort-By-Core Directory Structure"
 echo "   -bm : Create Sort-By-Manufacturer Directory Structure"
 echo "   -by : Create Sort-By-Year Directory Structure"
 echo "   -mr : Create Last 25 Arcade MRA Updates Directory Structure"
 echo "       : Passing a number overides the default 25"
 echo 
 echo "switches:"
 echo "     -v : verbose output"
 echo
 echo "example:"
 echo "     ./mra_sort_scan -mr 35"
 echo
}

# ========= CODE STARTS HERE =========

SORT_BY_MFG() {

for MRA in $(find ${MRA_PATH} -type f -name "*.mra"); do
  MRA_NAME=$(basename "${MRA}")
  MRA_REAL=$(basename "${MRA}" | awk -F. {'print $1'})
  MFG_NAME=$(sed -ne '/manufacturer/{s/.*<manufacturer>\(.*\)<\/manufacturer>.*/\1/p;q;}' ${MRA} | awk -F\( {'print $1'})
  CORE_NAME=$(sed -ne '/rbf/{s/.*<rbf>\(.*\)<\/rbf>.*/\1/p;q;}' ${MRA} | awk -F\( {'print $1'})

  case ${MFG_NAME} in
    [c..C]apcom*) CORE_DIR="Capcom" ;;
    [s..S]ega*|Coreland*|Escape) CORE_DIR="Sega" ;;
    [i..I]rem*) CORE_DIR="Irem" ;;
    [a..A]tari*) CORE_DIR="Atari" ;;
    [k..K]onami*) CORE_DIR="Konami" ;;
    [u..U]niversal*) CORE_DIR="Universal" ;;
    [c..C]AVE) CORE_DIR="CAVE" ;;
    [c..C]enturi) CORE_DIR="Centuri" ;;
    [n..N]intendo*) CORE_DIR="Nintendo" ;;
    [n..N]ichibutsu*) CORE_DIR="Nichibutsu" ;;
    [n..N]amco*) CORE_DIR="Namco" ;;
    [o..O]rca*) CORE_DIR="Orca" ;;
    "Duncan B"*) CORE_DIR="Duncan Brown" ;;
    [g..G]ottlieb*) CORE_DIR="Gottlieb" ;;
    "Alpha Denshi"*) CORE_DIR="Alpha Denshi" ;;
    [b..B]ootleg*) CORE_DIR="BOOTLEG" ;;
    UPL*) CORE_DIR="UPL" ;;
    [t..T]ecmo*) CORE_DIR="Tecmo" ;;
    [h..H]oei*) CORE_DIR="Hoei" ;;
    "Data East"*) CORE_DIR="Data East" ;;
    "Dave Nutting"*) CORE_DIR="Midway" ;; 
    [m..M]idway*) CORE_DIR="Midway" ;; 
    "Bally Midway"*) CORE_DIR="Bally Midway" ;;
    [t..T]aito*) CORE_DIR="Taito" ;;
    [t..T]ehkan) CORE_DIR="Tehkan" ;;
    [f..F]alcon) CORE_DIR="Falcon" ;;
    [t..T]echnos*) CORE_DIR="Technos" ;;
    [t..T]echstar*) CORE_DIR="Techstar" ;;
    [t..T]elko*) CORE_DIR="Telko" ;;
    [s..S]tern*) CORE_DIR="Stern" ;;
    [s..S]igma*) CORE_DIR="Sigma" ;;
    [s..S]yzygy*) CORE_DIR="Syzygy" ;;
    [i..I]tisa*) CORE_DIR="Itisa" ;;
    [v..V]aladon*) CORE_DIR="Valadon" ;;
    [w..W]illiams*) CORE_DIR="Williams" ;;
    "General Computer"*) CORE_DIR="GCC" ;;
    [r..R]ait*) CORE_DIR="Raid" ;;
    TDS*) CORE_DIR="TDS" ;;
    MTM*) CORE_DIR="MTM" ;;
    Vision*) CORE_DIR="Vision" ;;
    "Crazy Ivan"*) CORE_DIR="Crazy Ivan" ;;
    [c..C]omsoft*) CORE_DIR="Comsoft" ;;
    [s..S]ubelectro*) CORE_DIR="Subelectro" ;;
    [a..A]rmenia*) CORE_DIR="Armenia" ;;
    [e..E]pos*) CORE_DIR="Epos" ;;
    Mitchell*) CORE_DIR="Capcom" ;;
    [z..Z]ilec*) CORE_DIR="Zilec" ;;
    Kyoei*) CORE_DIR="Kyoei" ;;
    "Electronic Games Systems") CORE_DIR="Electronic Games Systems" ;;
  esac

  if [ ! -n "${CORE_DIR}" ]; then
    case ${CORE_NAME} in
     segasys*) CORE_DIR="Sega" ;;
     jtbubl*) CORE_DIR="Taito" ;;
     jtdd*) CORE_DIR="Technos" ;;
     jtpopey*) CORE_DIR="Nintendo" ;;
     jtcomsc|jtcontra) CORE_DIR="Konami" ;;
     jtcom*|jtf1*|jtgng*|jtgun*|jtsf|jthige|jtsarms|jtcps*|jttrojan|jt194*|jtbio*|jtbtig*|jtvulg*|jtsect*|jttor*) CORE_DIR="Capcom" ;;
    esac
  fi

  echo "Processing: ${MRA_REAL} - Manufacturer: ${CORE_DIR}"
  if [ -n "${CORE_DIR}" ]; then
    [[ ! -d ${MRA_PATH}/"_.By Manufacturer"/"_${CORE_DIR}" ]] && mkdir ${MKDIR_OPT} ${MRA_PATH}/"_.By Manufacturer"/"_${CORE_DIR}" 
    if [ ! -L ${MRA_PATH}/"_.By Manufacturer"/"_${CORE_DIR}"/${MRA_NAME} ]; then
      ln ${LN_OPT} ${MRA} ${MRA_PATH}/"_.By Manufacturer"/"_${CORE_DIR}"/${MRA_NAME}
    fi
  else
    [[ ${SWITCH} == "-v" ]] && echo "Malformed MRA : ${MRA} - CORE:${CORE_NAME} - CORE_DIR: ${CORE_DIR} - MANUFACTUER: ${MFG_NAME}"
  fi

  unset CORE_NAME CORE_DIR MFG_NAME
done

}

SORT_BY_CORE() {

for MRA in $(find ${MRA_PATH} -type f -name "*.mra"); do
  MRA_NAME=$(basename "${MRA}")
  MRA_REAL=$(basename "${MRA}" | awk -F. {'print $1'})
  CORE_NAME=$(sed -ne '/rbf/{s/.*<rbf>\(.*\)<\/rbf>.*/\1/p;q;}' ${MRA} | awk -F\( {'print $1'})
  CORE_DIR=${CORE_NAME}

  echo "Processing: ${MRA_REAL} - Core: ${CORE_NAME}"
  if [ -n "${CORE_DIR}" ]; then
    [[ ! -d ${MRA_PATH}/"_.By Core"/"_${CORE_DIR}" ]] && mkdir ${MKDIR_OPT} ${MRA_PATH}/"_.By Core"/"_${CORE_DIR}"
    if [ ! -L ${MRA_PATH}/"_.By Core"/"_${CORE_DIR}"/${MRA_NAME} ]; then
      ln ${LN_OPT} ${MRA} ${MRA_PATH}/"_.By Core"/"_${CORE_DIR}"/${MRA_NAME}
    fi
  else
    [[ ${SWITCH} == "-v" ]] && echo "Malformed MRA : ${MRA} - CORE:${CORE_NAME} - CORE_DIR: ${CORE_DIR} - MANUFACTUER: ${MFG_NAME}"
  fi

  unset CORE_NAME CORE_DIR MFG_NAME
done

}

SORT_BY_YEAR() {

for MRA in $(find ${MRA_PATH} -type f -name "*.mra"); do
  MRA_NAME=$(basename "${MRA}")
  MRA_REAL=$(basename "${MRA}" | awk -F. {'print $1'})
  CORE_YEAR=$(sed -ne '/year/{s/.*<year>\(.*\)<\/year>.*/\1/p;q;}' ${MRA} | awk -F\( {'print $1'})
  CORE_DIR=${CORE_YEAR}
  CORE_YEAR_RE='^[0-9]+$'

  echo "Processing: ${MRA_REAL} - Year: ${CORE_YEAR}"
  if [[ ${CORE_YEAR} =~ ${CORE_YEAR_RE} ]]; then
    if [ -n "${CORE_DIR}" ]; then
      [[ ! -d ${MRA_PATH}/"_.By Year"/"_${CORE_DIR}" ]] && mkdir ${MKDIR_OPT} ${MRA_PATH}/"_.By Year"/"_${CORE_DIR}"
      if [ ! -L ${MRA_PATH}/"_.By Year"/"_${CORE_DIR}"/${MRA_NAME} ]; then
        ln ${LN_OPT} ${MRA} ${MRA_PATH}/"_.By Year"/"_${CORE_DIR}"/${MRA_NAME}
      fi
    else
     [[ ${SWITCH} == "-v" ]] && echo "Malformed MRA : ${MRA} - CORE:${CORE_NAME} - CORE_DIR: ${CORE_DIR} - MANUFACTUER: ${MFG_NAME}"
    fi
  else
    echo
    echo "Error: ${MRA_REAL} - Year: ${CORE_YEAR}"
    echo
  fi
  unset CORE_NAME CORE_DIR CORE_YEAR
done

}

MOST_RECENT() {
[[ ! -d "${MRA_RECENT_DIR}" ]] && mkdir ${MKDIR_OPT} "${MRA_RECENT_DIR}"

SWITCH_RE='^[0-9]+$'

[[ ${SWITCH} =~ ${SWITCH_RE} ]] && MRA_RECENT_LEN=${SWITCH} || MRA_RECENT_LEN="25"

LAST_25_MRA=$(ls -tr ${MRA_PATH}/*.mra | tail -${MRA_RECENT_LEN})

for MRA in ${LAST_25_MRA}; do
  LAST_25_MRA_LIST="${LAST_25_MRA_LIST} ${MRA}"
  if [ -f "${MRA}" ]; then
    MRA_NAME=$(basename ${MRA})
    MFG_NAME=$(sed -ne '/manufacturer/{s/.*<manufacturer>\(.*\)<\/manufacturer>.*/\1/p;q;}' ${MRA} | awk -F\( {'print $1'})
    CORE_NAME=$(sed -ne '/rbf/{s/.*<rbf>\(.*\)<\/rbf>.*/\1/p;q;}' ${MRA} | awk -F\( {'print $1'})
    echo "Processing: ${MRA_NAME} - Manufacturer: ${MFG_NAME} - Core: ${CORE_NAME}"

    if [ ! -L "${MRA_RECENT_DIR}/${MRA_NAME}" ]; then
      ln ${LN_OPT} ${MRA} "${MRA_RECENT_DIR}/${MRA_NAME}"
    fi

  fi
  unset MRA MRA_NAME MFG_NAME CORE_NAME
done

for MRA in ${MRA_RECENT_DIR}/*; do
  MRA_NAME=$(basename ${MRA})
  if ! echo ${LAST_25_MRA_LIST} | grep -q ${MRA_NAME}; then
    rm -fv ${MRA} | logger -t mra_sort_scan
  fi
done

}

SORT_BY_PLATFORM() {

for MRA in $(find ${MRA_PATH} -type f -name "*.mra"); do
  MRA_NAME=$(basename "${MRA}")
  MRA_REAL=$(basename "${MRA}" | awk -F. {'print $1'})
  MFG_NAME=$(sed -ne '/manufacturer/{s/.*<manufacturer>\(.*\)<\/manufacturer>.*/\1/p;q;}' ${MRA} | awk -F\( {'print $1'})
  CORE_NAME=$(sed -ne '/rbf/{s/.*<rbf>\(.*\)<\/rbf>.*/\1/p;q;}' ${MRA} | awk -F\( {'print $1'})

  case ${CORE_NAME} in
    segasys1*|SEGASYS1*) CORE_DIR="Sega System 1" ;;
    segasys2*|SEGASYS2*) CORE_DIR="Sega System 2" ;;
    segasyse*|SEGASYSE*) CORE_DIR="Sega System E" ;;
    segasys16*|SEGASYSE*) CORE_DIR="Sega System 16" ;;
    segasys18*|SEGASYSE*) CORE_DIR="Sega System 18" ;;
    jtcps1) CORE_DIR="Capcom CPS1" ;;
    jtcps15) CORE_DIR="Capcom CPS1.5" ;;
    jtcps2) CORE_DIR="Capcom CPS2" ;;
    jtcps3) CORE_DIR="Capcom CPS3" ;;
    iremm62) CORE_DIR="Irem M62" ;;
  esac

  echo "Processing: ${MRA_REAL} - Core: ${CORE_DIR}"
  if [ -n "${CORE_DIR}" ]; then
    [[ ! -d ${MRA_PATH}/"_.By Platform"/"_${CORE_DIR}" ]] && mkdir ${MKDIR_OPT} ${MRA_PATH}/"_.By Platform"/"_${CORE_DIR}"
    if [ ! -L ${MRA_PATH}/"_.By Platform"/"_${CORE_DIR}"/${MRA_NAME} ]; then
      ln ${LN_OPT} ${MRA} ${MRA_PATH}/"_.By Platform"/"_${CORE_DIR}"/${MRA_NAME}
    fi
  else
    [[ ${SWITCH} == "-v" ]] && echo "Malformed MRA : ${MRA} - CORE:${CORE_NAME} - CORE_DIR: ${CORE_DIR} - MANUFACTUER: ${MFG_NAME}"
  fi

  unset CORE_NAME CORE_DIR MFG_NAME
done

}


case ${OPTION} in
 -bm) SORT_BY_MFG ;;
 -bc) SORT_BY_CORE ;;
 -by) SORT_BY_YEAR ;;
 -bp) SORT_BY_PLATFORM ;;
 -mr) MOST_RECENT ;;

 *) USAGE ;;
esac
